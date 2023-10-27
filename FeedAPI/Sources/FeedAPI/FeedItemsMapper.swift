import Foundation
import FeedFeature

public final class FeedItemsMapper {

    public enum Error: Swift.Error {
        case invalidData
    }

    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [FeedImage] {
        throw Error.invalidData
    }
}
