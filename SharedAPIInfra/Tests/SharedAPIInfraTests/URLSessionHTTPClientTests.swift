import XCTest
import SharedAPIInfra
@testable import SharedAPIInfra

final class URLSessionHTTPClientTest: XCTestCase {
    func test_getFromURL_returnsWithoutCrashing() {
        let sut = URLSessionHTTPClient()
        _ = sut.get(from: URL(string: "https://google.com")!, completion: { _ in

        })
    }
}
