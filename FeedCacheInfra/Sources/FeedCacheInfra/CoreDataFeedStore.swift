import CoreData
import FeedCache

public final class CoreDataFeedStore {
    
    public init(storeURL: URL) throws {
    }
}

extension CoreDataFeedStore: FeedStore {
    public func deleteCachedFeed() throws { }
    
    public func insert(_ feed: [FeedCache.LocalFeedImage], timestamp: Date) throws { }

    public func retrieve() throws -> FeedCache.CachedFeed? {
        nil
    }
}
