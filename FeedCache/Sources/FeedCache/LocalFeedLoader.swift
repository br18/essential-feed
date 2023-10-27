//
//  File.swift
//  
//
//  Created by Ben Rosen on 27/10/2023.
//

import Foundation
import FeedFeature

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date

    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }

    public func save(_ feed: [FeedImage]) throws {
        try store.deleteCachedFeed()
    }
}

