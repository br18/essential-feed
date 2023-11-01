import Foundation
import FeedFeature

public final class FeedImagePresenter {
    public static func map(_ image: FeedImage) -> FeedImageViewModel {
        return FeedImageViewModel(description: image.description,
                                  location: image.location)
    }
}
