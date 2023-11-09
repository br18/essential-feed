import Foundation
import FeedFeature

public final class LocalFeedImageDataLoader {
    private let store: FeedImageDataStore

    public init(store: FeedImageDataStore) {
        self.store = store
    }
}

extension LocalFeedImageDataLoader: FeedImageDataCache {
    public func save(_ data: Data, for url: URL) throws {
        try? store.insert(data, for: url)
    }
}
