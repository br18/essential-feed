//
//  SceneDelegate.swift
//  EssentialApp
//
//  Created by Ben Rosen on 13/10/2023.
//

import os
import UIKit
import Combine
import FeedFeature
import SharedAPI
import FeedCache
import SharedAPIInfra
import FeedAPI
import FeedCacheInfra
import CoreData
import ImageCommentsAPI
import ImageCommentsFeature

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private lazy var scheduler: AnyDispatchQueueScheduler = DispatchQueue(
        label: "com.essentialdeveloper.infra.queue",
        qos: .userInitiated,
        attributes: .concurrent
    ).eraseToAnyScheduler()

    private lazy var httpClient: HTTPClient = {
        URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
    }()

    private lazy var logger = Logger(subsystem: "com.essentialdeveloper.EssentialAppCaseStudy", category: "main")

    private lazy var store: FeedStore & FeedImageDataStore = {
        do {
            return try CoreDataFeedStore(
                storeURL: NSPersistentContainer
                    .defaultDirectoryURL()
                    .appendingPathComponent("feed-store.sqlite"))
        } catch {
            assertionFailure("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            logger.fault("Failed to instantiate CoreData store with error: \(error.localizedDescription)")
            return NullStore()
        }
    }()

    private lazy var localFeedLoader: LocalFeedLoader = {
        LocalFeedLoader(store: store, currentDate: Date.init)
    }()

    private lazy var baseURL = URL(string: "https://ile-api.essentialdeveloper.com/essential-feed")!

    private lazy var navigationController = UINavigationController(
        rootViewController: FeedUIComposer.feedComposedWith(
            feedLoader: makeRemoteFeedLoaderWithLocalFallback,
            imageLoader: makeLocalImageLoaderWithRemoteFallback,
            selection: showComments(for:)))


    convenience init(httpClient: HTTPClient, store: FeedStore & FeedImageDataStore, scheduler: AnyDispatchQueueScheduler) {
        self.init()
        self.httpClient = httpClient
        self.store = store
        self.scheduler = scheduler
    }

    func configureWindow() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }

        window = UIWindow(windowScene: scene)
        configureWindow()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        try? localFeedLoader.validateCache()
    }

    private func showComments(for image: FeedImage) {
        let url = ImageCommentsEndpoint.get(image.id).url(baseURL: baseURL)
        let comments = CommentsUIComposer.commentsComposedWith(commentsLoader: makeRemoteCommentsLoader(url: url))
        navigationController.pushViewController(comments, animated: true)
    }

    private func makeRemoteCommentsLoader(url: URL) -> () -> AnyPublisher<[ImageComment], Error> {
        return { [httpClient] in
            return httpClient
                .getPublisher(url: url)
                .tryMap(ImageCommentsMapper.map)
                .eraseToAnyPublisher()
        }
    }

    private func makeRemoteFeedLoaderWithLocalFallback() -> AnyPublisher<Paginated<FeedImage>, Error> {
        makeRemoteFeedLoader()
            .caching(to: localFeedLoader)
            .fallback(to: localFeedLoader.loadPublisher)
            .map(makeFirstPage)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }

    private func makeRemoteLoadMoreLoader(last: FeedImage?) -> AnyPublisher<Paginated<FeedImage>, Error> {
        localFeedLoader.loadPublisher()
            .zip(makeRemoteFeedLoader(after: last))
            .map { (cachedItems, newItems) in
                (cachedItems + newItems, newItems.last)
            }
            .map(makePage)
            .caching(to: localFeedLoader)
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }

    private func makeRemoteFeedLoader(after: FeedImage? = nil) -> AnyPublisher<[FeedImage], Error> {
        let url = FeedEndpoint.get(after: after).url(baseURL: baseURL)

        return httpClient
            .getPublisher(url: url)
            .tryMap(FeedItemsMapper.map)
            .eraseToAnyPublisher()
    }

    private func makeFirstPage(items: [FeedImage]) -> Paginated<FeedImage> {
        makePage(items: items, last: items.last)
    }

    private func makePage(items: [FeedImage], last: FeedImage?) -> Paginated<FeedImage> {
        Paginated(items: items, loadMorePublisher: last.map { last in
            { self.makeRemoteLoadMoreLoader(last: last) }
        })
    }

    private func makeLocalImageLoaderWithRemoteFallback(url: URL) -> FeedImageDataLoader.Publisher {
        let localImageLoader = LocalFeedImageDataLoader(store: store)

        return localImageLoader
            .loadImageDataPublisher(from: url)
            .fallback(to: { [httpClient, scheduler] in
                httpClient
                    .getPublisher(url: url)
                    .tryMap(FeedImageDataMapper.map)
                    .caching(to: localImageLoader, using: url)
                    .subscribe(on: scheduler)
                    .eraseToAnyPublisher()
            })
            .subscribe(on: scheduler)
            .eraseToAnyPublisher()
    }

    private func makeRemoteLoadMoreLoader(items: [FeedImage], last: FeedImage?) -> (() -> AnyPublisher<Paginated<FeedImage>, Error>)? {
        last.map { lastItem in
            let url = FeedEndpoint.get(after: lastItem).url(baseURL: baseURL)

            return { [httpClient, localFeedLoader] in
                httpClient
                    .getPublisher(url: url)
                    .tryMap(FeedItemsMapper.map)
                    .map { newItems in
                        let allItems = items + newItems
                        return Paginated(items: allItems, loadMorePublisher: self.makeRemoteLoadMoreLoader(items: allItems, last: newItems.last))
                    }.caching(to: localFeedLoader)
            }
        }
    }
}

