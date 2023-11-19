import Foundation
import UIKit
import SharedUI
import ImageCommentsFeature
import Combine
import ImageCommentsPresentation
import ImageCommentsUI

public final class CommentsUIComposer {
    private init() {}

    public static func commentsComposedWith(
        commentsLoader: @escaping () -> AnyPublisher<[ImageComment], Error>
    ) -> ListViewController {
        return makeCommentsViewController(title: ImageCommentsPresenter.title)
    }

    private static func makeCommentsViewController(title: String) -> ListViewController {
        let bundle = ImageCommentsUI.bundle
        let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! ListViewController
        controller.title = title
        return controller
    }
}
