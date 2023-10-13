import XCTest
import SharedAPI
import SharedAPIInfra
import SharedTestHelpers
@testable import SharedAPIInfra

final class URLSessionHTTPClientTest: XCTestCase {
    func test_getFromURL_returnsWithoutCrashing() {
        let sut = URLSessionHTTPClient()
        _ = sut.get(from: URL(string: "https://google.com")!, completion: { _ in
            
        })
    }
    
    private func makeSut(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let sut = URLSessionHTTPClient()
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
