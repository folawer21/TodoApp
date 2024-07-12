//
//  MockNetwork.swift
//  TodoAppTests
//
//  Created by Александр  Сухинин on 12.07.2024.
//

import Foundation

class MockURLSession: URLSession {
    var url: URL?
    var request: URLRequest?
    var data: Data?
    var response: URLResponse?
    var error: Error?
    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        self.request = request
        return MockURLSessionDataTask {
            completionHandler(self.data, self.response, self.error)
        }
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    private let closure: () -> Void
    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    override func resume() {
        closure()
    }
    override func cancel() {
    }
}
