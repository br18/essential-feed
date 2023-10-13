//
//  FeedItemsMapperTests.swift
//  
//
//  Created by Ben Rosen on 13/10/2023.
//

import XCTest
import FeedAPI

final class FeedItemsMapperTests: XCTestCase {

    func test_map_doesNotCrash() throws {
        _ = try FeedItemsMapper.map(Data(), from: HTTPURLResponse())
    }

}
