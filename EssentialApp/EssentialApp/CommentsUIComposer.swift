import Foundation
import SharedUI
import ImageCommentsFeature
import Combine
import ImageCommentsPresentation

public final class CommentsUIComposer {
    private init() {}

    public static func commentsComposedWith(
        commentsLoader: @escaping () -> AnyPublisher<[ImageComment], Error>
    ) -> ListViewController {
        let viewController = ListViewController()
        viewController.title = ImageCommentsPresenter.title
        return viewController
    }
}
