import Foundation
import FeedPresentation
import SharedUI
import SharedPresentation
import FeedFeature
import UIKit
import FeedUI

final class FeedViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    private let selection: (FeedImage) -> Void
    private let currentFeed: [FeedImage: CellController]

    init(currentFeed: [FeedImage: CellController] = [:], controller: ListViewController, selection: @escaping (FeedImage) -> Void) {
        self.currentFeed = currentFeed
        self.controller = controller
        self.selection = selection
    }

    func display(_ viewModel: [FeedImage]) {
        guard let controller = controller else { return }

        var currentFeed = self.currentFeed
        let feed: [CellController] = viewModel.map { model in
            if let controller = currentFeed[model] {
                return controller
            }


            let view = FeedImageCellController(
                viewModel: FeedImagePresenter.map(model),
                selection: { [selection] in
                    selection(model)
                })

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
