//
//  TodoAppTests.swift
//  TodoAppTests
//
//  Created by Александр  Сухинин on 12.07.2024.
//
import XCTest
@testable import TodoApp

final class NetworkTests: XCTestCase {

    func testDataTaskSuccess() async throws {
        let mockData = "Test data".data(using: .utf8)
        let mockResponse = HTTPURLResponse(url: URL(string: "https://example.com")!,
                                           statusCode: 200, httpVersion: nil, headerFields: nil)
        let mockSession = MockURLSession()
        mockSession.data = mockData
        mockSession.response = mockResponse
        let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
        let (data, response) = try await mockSession.dataTask(for: urlRequest)
        XCTAssertEqual(data, mockData)
        XCTAssertEqual(response.url, mockResponse?.url)
        XCTAssertEqual((response as? HTTPURLResponse)?.statusCode, mockResponse?.statusCode)
    }
    func testDataTaskFailure() async {
        let mockError = URLError(.notConnectedToInternet)
        let mockSession = MockURLSession()
        mockSession.error = mockError
        let urlRequest = URLRequest(url: URL(string: "https://example.com")!)
        do {
            _ = try await mockSession.dataTask(for: urlRequest)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual((error as? URLError)?.code, mockError.code)
        }
    }
    func testGetTodoList() async throws {
        let networkService = NetworkService()
        let todoList = try await networkService.getTodoList()
        
    }
}
