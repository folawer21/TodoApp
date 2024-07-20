//
//  NetworkServiceProtocol.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 20.07.2024.
//

import Foundation

protocol NetworkServiceProtocol: AnyObject {
    func getTodoList() async throws -> [TodoItem]
    func getTodoItemById(id: String) async throws -> TodoItem
    func changeTodoItemById(todoItem: TodoItem) async throws -> TodoItem
    func deleteTodoItemById(id: String) async throws -> TodoItem
    func addTodoItem(todoItem: TodoItem) async throws
    func updateTodoList(todoList: [TodoItem]) async throws -> [TodoItem]
}
