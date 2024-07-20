//
//  NetworkService.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 18.07.2024.
//

import Foundation

final class NetworkService: NetworkServiceProtocol {
    lazy var decoder = JSONDecoder()
    lazy var encoder = JSONEncoder()
    private var revision: Int32 = 0
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
                let revisionResponse = todoListResponse.revision
                self.revision = revisionResponse
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
                let todoItemResponse =  try decoder.decode(GetTodoItemByIdResponse.self, from: data)
                let revisionResponse = todoItemResponse.revision
                let todoItemNetwork = todoItemResponse.element
                self.revision = revisionResponse
                let todoItem = TodoItem(todoNetwork: todoItemNetwork)
                return todoItem
            } catch {
                throw NetworkServiceErrors.decodingUnsuccessful
            }
        } catch {
            throw NetworkServiceErrors.urlSessionError
        }
    }
    func changeTodoItemById(todoItem: TodoItem) async throws -> TodoItem {
        let id = todoItem.id
        let todoNetwork = TodoNetwork(from: todoItem)
        let todoResponse = TodoBodyResponse(element: todoNetwork)
        guard var urlRequest = changeTodoItemByIdURLRequest(id: id) else {
            throw NetworkServiceErrors.invalidHTTPRequest
        }
        do {
            urlRequest.httpBody = try encoder.encode(todoResponse)
            do {
                let (data, response) = try await URLSession.shared.dataTask(for: urlRequest)
                guard let responseHTTP = response  as? HTTPURLResponse,
                      responseHTTP.statusCode == 200 else {
                    throw NetworkServiceErrors.badResponse
                }
                do {
                    let todoItemResponse =  try decoder.decode(GetTodoItemByIdResponse.self, from: data)
                    let revisionResponse = todoItemResponse.revision
                    let todoItemNetwork = todoItemResponse.element
                    self.revision = revisionResponse
                    let todoItem = TodoItem(todoNetwork: todoItemNetwork)
                    return todoItem
                } catch {
                    throw NetworkServiceErrors.decodingUnsuccessful
                }
            } catch {
                throw NetworkServiceErrors.urlSessionError
            }
        } catch {
            throw NetworkServiceErrors.encodingUnsuccessful
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
                let todoItemResponse =  try decoder.decode(GetTodoItemByIdResponse.self, from: data)
                let revisionResponse = todoItemResponse.revision
                let todoItemNetwork = todoItemResponse.element
                self.revision = revisionResponse
                let todoItem = TodoItem(todoNetwork: todoItemNetwork)
                return todoItem
            } catch {
                throw NetworkServiceErrors.decodingUnsuccessful
            }
        } catch {
            throw NetworkServiceErrors.urlSessionError
        }
    }
    func addTodoItem(todoItem: TodoItem) async throws {
        let todoNetwork = TodoNetwork(from: todoItem)
        guard var request = addTodoItemByIdURLRequest() else {
            throw NetworkServiceErrors.invalidHTTPRequest
        }
        let todoResponse = TodoBodyResponse(element: todoNetwork)
        do {
            request.httpBody = try encoder.encode(todoResponse)
            do {
                let (data, response) = try await URLSession.shared.dataTask(for: request)
                guard let responseHTTP = response  as? HTTPURLResponse,
                      responseHTTP.statusCode == 200 else {
                    throw NetworkServiceErrors.badResponse
                }
                do {
                    let todoItemResponse =  try decoder.decode(GetTodoItemByIdResponse.self, from: data)
                    let revisionResponse = todoItemResponse.revision
                    self.revision = revisionResponse
                } catch {
                    throw NetworkServiceErrors.decodingUnsuccessful
                }
            } catch {
                throw NetworkServiceErrors.urlSessionError
            }
        } catch {
            throw NetworkServiceErrors.encodingUnsuccessful
        }
    }
    func updateTodoList(todoList: [TodoItem]) async throws -> [TodoItem] {
        let todoNetworkList = todoList.map { TodoNetwork(from: $0) }
        guard var request = updateTodoListURLRequest() else {
            throw NetworkServiceErrors.invalidHTTPRequest
        }
        let todoListResponse = TodoListBodyResponse(list: todoNetworkList)
        do {
            request.httpBody = try encoder.encode(todoListResponse)
            do {
                let (data, response) = try await URLSession.shared.dataTask(for: request)
                guard let responseHTTP = response  as? HTTPURLResponse,
                      responseHTTP.statusCode == 200 else {
                    throw NetworkServiceErrors.badResponse
                }
                do {
                    let todoItemResponse =  try decoder.decode(GetTodoListResponse.self, from: data)
                    let revisionResponse = todoItemResponse.revision
                    let todoItemsNetwork = todoItemResponse.list
                    let todoItems = todoItemsNetwork.map { TodoItem(todoNetwork: $0) }
                    self.revision = revisionResponse
                    return todoItems
                } catch {
                    throw NetworkServiceErrors.decodingUnsuccessful
                }
            } catch {
                throw NetworkServiceErrors.urlSessionError
            }
        } catch {
            throw NetworkServiceErrors.encodingUnsuccessful
        }
    }
}

extension NetworkService {
    private func getTodoListURLRequest() -> URLRequest? {
        guard let url = URL(string: NetworkDefault.todoListRequestURLString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        return request
    }
    private func getTodoItemByIdURLRequest(id: String) -> URLRequest? {
        let urlString = NetworkDefault.getItemByIdRequestURLString + id
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        return request
    }
    private func changeTodoItemByIdURLRequest(id: String) -> URLRequest? {
        let urlString = NetworkDefault.changeItemByIdRequestURLString + id
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        request.addValue("\(revision)", forHTTPHeaderField: "X-Last-Known-Revision")
        return request
    }
    private func deleteTodoItemByIdURLRequest(id: String) -> URLRequest? {
        let urlString = NetworkDefault.deleteItemByIdRequestURLString + id
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        request.addValue("\(revision)", forHTTPHeaderField: "X-Last-Known-Revision")
        return request
    }
    private func addTodoItemByIdURLRequest() -> URLRequest? {
        let urlString = NetworkDefault.addItemRequestURLString
        guard let url = URL(string: urlString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        request.addValue("\(revision)", forHTTPHeaderField: "X-Last-Known-Revision")
        return request
    }
    private func updateTodoListURLRequest() -> URLRequest? {
        guard let url = URL(string: NetworkDefault.todoListRequestURLString) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("Bearer \(NetworkDefault.token)", forHTTPHeaderField: "Authorization")
        request.addValue("\(revision)", forHTTPHeaderField: "X-Last-Known-Revision")
        return request
    }
}
