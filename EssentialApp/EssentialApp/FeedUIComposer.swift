import Foundation
import UIKit
import FeedFeature
import Combine
import SharedUI
import FeedPresentation
import FeedUI
import SharedPresentation

public final class FeedUIComposer {

    private typealias FeedPresentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>


    public static func feedComposedWith(
        feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>,
        selection: @escaping (FeedImage) -> Void = { _ in }
    ) -> ListViewController {

        let presentationAdapter = FeedPresentationAdapter(loader: feedLoader)
        let feedController = makeFeedViewController(title: FeedPresenter.title)
        feedController.onRefresh = presentationAdapter.loadResource

        presentationAdapter.presenter = LoadResourcePresenter(
            resourceView: FeedViewAdapter(
                controller: feedController,
                selection: selection),
            loadingView: WeakRefVirtualProxy(feedController),
            errorView: WeakRefVirtualProxy(feedController))

        return feedController
    }

    private static func makeFeedViewController(title: String) -> ListViewController {
        let bundle = FeedUI.bundle
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! ListViewController
        feedController.title = title
        return feedController
    }

}