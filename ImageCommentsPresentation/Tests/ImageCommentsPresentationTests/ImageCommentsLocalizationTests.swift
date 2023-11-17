import Foundation
import SharedTestHelpers
import ImageCommentsPresentation
import XCTest

class ImageCommentsLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "ImageComments"
        let bundle = ImageCommentsPresentation.bundle

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }

}
