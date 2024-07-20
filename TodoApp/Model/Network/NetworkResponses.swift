//
//  NetworkResponses.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 20.07.2024.
//

import Foundation

struct GetTodoListResponse: Codable {
    let status: String
    let list: [TodoNetwork]
    let revision: Int32
}

struct GetTodoItemByIdResponse: Codable {
    let status: String
    let element: TodoNetwork
    let revision: Int32
}

enum NetworkServiceErrors: Error {
    case invalidHTTPRequest
    case badResponse
    case decodingUnsuccessful
    case urlSessionError
    case encodingUnsuccessful
}

struct TodoBodyResponse: Codable {
    let element: TodoNetwork
}

struct TodoListBodyResponse: Codable {
    let list: [TodoNetwork]
}
