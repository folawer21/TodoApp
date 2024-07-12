//
//  URLSession+dataTask.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 12.07.2024.
//

import Foundation
extension URLSession {
    func dataTask(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        return try await withCheckedThrowingContinuation { continuation in
            let task = dataTask(with: urlRequest) { data, response, error in
                if Task.isCancelled {
                    continuation.resume(throwing: CancellationError())
                    return
                }
                if let error = error {
                    continuation.resume(throwing: error)
                    return
                }
                guard let data = data, let response = response else {
                    continuation.resume(throwing: URLError(.badServerResponse))
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
            Task {
                if Task.isCancelled {
                    task.cancel()
                    continuation.resume(throwing: CancellationError())
                }
            }
        }
    }
}
