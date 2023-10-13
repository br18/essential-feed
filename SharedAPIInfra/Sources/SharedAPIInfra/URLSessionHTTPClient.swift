//
//  File.swift
//  
//
//  Created by Ben Rosen on 13/10/2023.
//

import Foundation
import SharedAPI

public final class URLSessionHTTPClient: HTTPClient {

    private let session: URLSession

    public init(session: URLSession) {
        self.session = session
    }

    private struct URLSessionTaskWrapper: HTTPClientTask {
        func cancel() {

        }
    }

    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url)
        task.resume()
        return URLSessionTaskWrapper()
    }
}
