import Foundation

public final class ImageCommentsPresenter {
    public static var title: String {
        NSLocalizedString("IMAGE_COMMENTS_VIEW_TITLE",
                          tableName: "ImageComments",
                          bundle: ImageCommentsPresentation.bundle,
                          comment: "Title for the image comments view")
    }
}
