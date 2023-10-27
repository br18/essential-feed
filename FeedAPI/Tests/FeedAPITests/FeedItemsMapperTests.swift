//
//  FeedItemsMapperTests.swift
//  
//
//  Created by Ben Rosen on 13/10/2023.
//

import XCTest
import FeedAPI
import SharedTestHelpers

final class FeedItemsMapperTests: XCTestCase {

    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 201, 300, 400, 500]

        try samples.forEach { code in
            XCTAssertThrowsError(
                try FeedItemsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }

}
