//
//  NetworkService.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 18.07.2024.
//

import Foundation

struct TodoNetwork: Codable {
    let id: UUID
    let text: String
    let importance: Importance
    let deadline: Date?
    let done: Bool
    let color: String?
    let createdAt: Date
    let changedAt: Date
    let lastUpdatedBy: Int
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case importance
        case deadline
        case done
        case color
        case createdAt = "created_at"
        case changedAt = "changed_at"
        case lastUpdatedBy = "last_updated_by"
    }
    init(from item: TodoItem) {
        self.id = UUID(uuidString: item.id) ?? UUID()
        self.text = item.text
        self.importance = item.importance
        self.deadline = item.deadline
        self.done = item.isDone
        self.color = item.color.hexString()
        self.createdAt = item.createdAt
        self.changedAt = item.changedAt ?? Date()
        self.lastUpdatedBy = 1110101
    }
}

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
}

//TODO: Сделать протокол и подписать NetworkService на него для скрытия реализации
final class NetworkService {
    lazy var decoder = JSONDecoder()
    func getTodoListURLRequest() -> URLRequest? {
        guard let url = URL(string: NetworkDefault.todoListRequestURLString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        return request
    }
    func getTodoItemByIdURLRequest(id: String) -> URLRequest? {
        let urlString = NetworkDefault.getItemByIdRequestURLString + id
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        return request
    }
    func changeTodoItemByIdURLRequest(id: String) -> URLRequest? {
        let urlString = NetworkDefault.changeItemByIdRequestURLString + id
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        return request
    }
    func deleteTodoItemByIdURLRequest(id: String) -> URLRequest? {
        let urlString = NetworkDefault.deleteItemByIdRequestURLString + id
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        return request
    }
    func getTodoList() async throws -> [TodoItem] {
        guard let urlRequest = getTodoListURLRequest() else {
            throw NetworkServiceErrors.invalidHTTPRequest
        }
        do {
            let (data, response) = try await URLSession.shared.dataTask(for: urlRequest)
            do {
                guard let responseHTTP = response as? HTTPURLResponse,
                      responseHTTP.statusCode == 200 else {
                    throw NetworkServiceErrors.badResponse
                }
                let todoListResponse = try decoder.decode(GetTodoListResponse.self, from: data)
                let todoListNetwork = todoListResponse.list
                let todoList = todoListNetwork.map {
                    TodoItem(todoNetwork: $0)
                }
                return todoList
            } catch {
                throw NetworkServiceErrors.decodingUnsuccessful
            }
        } catch {
            throw NetworkServiceErrors.urlSessionError
        }

    }
    func getTodoItemById(id: String) async throws -> TodoItem {
        guard let urlRequest = getTodoItemByIdURLRequest(id: id) else {
            throw NetworkServiceErrors.invalidHTTPRequest
        }
        do {
            let (data, response) = try await URLSession.shared.dataTask(for: urlRequest)
            guard let responseHTTP = response  as? HTTPURLResponse,
                  responseHTTP.statusCode == 200 else {
                throw NetworkServiceErrors.badResponse
            }
            do {
                let todoItemNetwork = try decoder.decode(TodoNetwork.self, from: data)
                let todoItem = TodoItem(todoNetwork: todoItemNetwork)
                return todoItem
            } catch {
                throw NetworkServiceErrors.decodingUnsuccessful
            }
        } catch {
            throw NetworkServiceErrors.urlSessionError
        }
    }
    func changeTodoItemById(id: String) async throws -> TodoItem {
        guard let urlRequest = changeTodoItemByIdURLRequest(id: id) else {
            throw NetworkServiceErrors.invalidHTTPRequest
        }
        do {
            let (data, response) = try await URLSession.shared.dataTask(for: urlRequest)
            guard let responseHTTP = response  as? HTTPURLResponse,
                  responseHTTP.statusCode == 200 else {
                throw NetworkServiceErrors.badResponse
            }
            do {
                let todoItemNetwork = try decoder.decode(TodoNetwork.self, from: data)
                let todoItem = TodoItem(todoNetwork: todoItemNetwork)
                return todoItem
            } catch {
                throw NetworkServiceErrors.decodingUnsuccessful
            }
        } catch {
            throw NetworkServiceErrors.urlSessionError
        }
    }
    func deleteTodoItemById(id: String) async throws -> TodoItem {
        guard let urlRequest = deleteTodoItemByIdURLRequest(id: id) else {
            throw NetworkServiceErrors.invalidHTTPRequest
        }
        do {
            let (data, response) = try await URLSession.shared.dataTask(for: urlRequest)
            guard let responseHTTP = response  as? HTTPURLResponse,
                  responseHTTP.statusCode == 200 else {
                throw NetworkServiceErrors.badResponse
            }
            do {
                let todoItemNetwork = try decoder.decode(TodoNetwork.self, from: data)
                let todoItem = TodoItem(todoNetwork: todoItemNetwork)
                return todoItem
            } catch {
                throw NetworkServiceErrors.decodingUnsuccessful
            }
        } catch {
            throw NetworkServiceErrors.urlSessionError
        }
    }
    func addTodoItem(todoItem: TodoItem) async throws -> TodoItem {
        let todoNetwork = TodoNetwork(from: todoItem)
        
    }
    
}
