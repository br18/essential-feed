import Foundation
import FeedCache

extension CoreDataFeedStore: FeedStore {
    public func deleteCachedFeed() throws { }

    public func insert(_ feed: [FeedCache.LocalFeedImage], timestamp: Date) throws {
        try performSync { context in
            Result {
                let managedCache = try ManagedCache.newUniqueInstance(in: context)
                managedCache.timestamp = timestamp
                managedCache.feed = ManagedFeedImage.images(from: feed, in: context)
                try? context.save()
            }
        }
    }

    public func retrieve() throws -> FeedCache.CachedFeed? {
        try performSync { context in
            Result {
                try? ManagedCache.find(in: context).map {
                    CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
                }
            }
        }
    }
}
