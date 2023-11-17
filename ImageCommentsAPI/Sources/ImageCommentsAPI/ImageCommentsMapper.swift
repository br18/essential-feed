import Foundation
import ImageCommentsFeature

public final class ImageCommentsMapper {

    private struct Error: Swift.Error {}

    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [ImageComment] {
        throw Error()
    }
}
