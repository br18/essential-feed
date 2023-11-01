import Foundation

public final class FeedPresenter {
    public static var title: String {
        NSLocalizedString("FEED_VIEW_TITLE",
            tableName: "Feed",
            bundle: FeedPresentation.bundle,
            comment: "Title for the feed view")
    }
}
