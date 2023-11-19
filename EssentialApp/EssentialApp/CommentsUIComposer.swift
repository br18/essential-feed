import Foundation
import UIKit
import SharedUI
import ImageCommentsFeature
import Combine
import ImageCommentsPresentation
import ImageCommentsUI
import SharedPresentation

public final class CommentsUIComposer {
    private typealias CommentsPresentationAdapter = LoadResourcePresentationAdapter<[ImageComment], CommentsViewAdapter>

    private init() {}

    public static func commentsComposedWith(
        commentsLoader: @escaping () -> AnyPublisher<[ImageComment], Error>
    ) -> ListViewController {

        let presentationAdapter = CommentsPresentationAdapter(loader: commentsLoader)

        let commentsController = makeCommentsViewController(title: ImageCommentsPresenter.title)
        commentsController.onRefresh = presentationAdapter.loadResource

        return commentsController
    }

    private static func makeCommentsViewController(title: String) -> ListViewController {
        let bundle = ImageCommentsUI.bundle
        let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! ListViewController
        controller.title = title
        return controller
    }
}

final class CommentsViewAdapter: ResourceView {
    func display(_ viewModel: ImageCommentsViewModel) { }
}
