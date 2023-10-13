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
        let wrapped: URLSessionTask

        func cancel() {
            wrapped.cancel()
        }
    }

    private struct TempError: Error {}

    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) -> HTTPClientTask {
        let task = session.dataTask(with: url) { _, _, error in
            completion(Result {
                if let error = error {
                    throw error
                } else {
                    throw TempError()
                }
            })
        }
        task.resume()
        return URLSessionTaskWrapper(wrapped: task)
    }
}
