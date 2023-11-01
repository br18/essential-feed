import Foundation
import FeedFeature
import SharedTestHelpers

func uniqueImage() -> FeedImage {
    return FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
}
