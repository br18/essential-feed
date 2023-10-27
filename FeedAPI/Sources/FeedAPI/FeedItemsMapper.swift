import Foundation
import FeedFeature

public final class FeedItemsMapper {
    private struct Root: Decodable {
        private let items: [RemoteFeedItem]

        private struct RemoteFeedItem: Decodable {
            let id: UUID
            let description: String?
            let location: String?
            let image: URL
        }
    }

    public enum Error: Swift.Error {
        case invalidData
    }

    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [FeedImage] {
        guard response.isOK, (try? JSONDecoder().decode(Root.self, from: data)) != nil else {
            throw Error.invalidData
        }

        return []
    }
}
