import XCTest
import SharedTestHelpers
import FeedPresentation

final class FeedLocalizationTests: XCTestCase {

    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Feed"
        let bundle = FeedPresentation.bundle

        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }

}
