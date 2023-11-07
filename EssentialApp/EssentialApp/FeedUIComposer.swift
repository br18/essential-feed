import Foundation
import UIKit
import FeedFeature
import Combine
import SharedUI
import FeedPresentation
import FeedUI

public final class FeedUIComposer {
    public static func feedComposedWith(
        feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>,
        selection: @escaping (FeedImage) -> Void = { _ in }
    ) -> ListViewController {
        let bundle = FeedUI.bundle
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedController = storyboard.instantiateInitialViewController() as! ListViewController
        feedController.title = FeedPresenter.title
        return feedController
    }
}
