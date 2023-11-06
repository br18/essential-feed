import Foundation
import FeedFeature
import Combine
import SharedUI
import FeedPresentation

public final class FeedUIComposer {
    public static func feedComposedWith(
        feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>,
        selection: @escaping (FeedImage) -> Void = { _ in }
    ) -> ListViewController {
        let viewController = ListViewController()
        viewController.title = FeedPresenter.title
        return viewController
    }
}
