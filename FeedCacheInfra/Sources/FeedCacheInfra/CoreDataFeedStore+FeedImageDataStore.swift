import Foundation
import FeedCache

extension CoreDataFeedStore: FeedImageDataStore {
    public func insert(_ data: Data, for url: URL) throws {

    }
    
    public func retrieve(dataForURL url: URL) throws -> Data? {
        return nil
    }
    
}
