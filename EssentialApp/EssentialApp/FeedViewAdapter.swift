import Foundation
import FeedPresentation
import SharedUI
import SharedPresentation
import FeedFeature
import UIKit
import FeedUI

final class FeedViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
    private let selection: (FeedImage) -> Void
    private let currentFeed: [FeedImage: CellController]

    private typealias ImageDataPresentationAdapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedImageCellController>>

    init(currentFeed: [FeedImage: CellController] = [:], controller: ListViewController,
         imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher,
         selection: @escaping (FeedImage) -> Void) {
        self.currentFeed = currentFeed
        self.controller = controller
        self.imageLoader = imageLoader
        self.selection = selection
    }

    func display(_ viewModel: [FeedImage]) {
        guard let controller = controller else { return }

        var currentFeed = self.currentFeed
        let feed: [CellController] = viewModel.map { model in
            if let controller = currentFeed[model] {
                return controller
            }

            let adapter = ImageDataPresentationAdapter(loader: { [imageLoader] in
                imageLoader(model.url)
            })


            let view = FeedImageCellController(
                viewModel: FeedImagePresenter.map(model),
                delegate: adapter,
                selection: { [selection] in
                    selection(model)
                })

            adapter.presenter = LoadResourcePresenter(
                resourceView: WeakRefVirtualProxy(view),
                loadingView: WeakRefVirtualProxy(view),
                errorView: WeakRefVirtualProxy(view),
                mapper: UIImage.tryMake)

            let controller = CellController(id: model, view)
            currentFeed[model] = controller
            return controller
        }

        controller.display(feed)
    }
}

extension UIImage {
    struct InvalidImageData: Error {}

    static func tryMake(data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else {
            throw InvalidImageData()
        }
        return image
    }
}
