//
//  NetworkStore.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 20.07.2024.
//

import Foundation
protocol NetworkStore: AnyObject {
    func getTodos() -> [TodoItem]
    func getTodoById(id: String) -> TodoItem?
    func changeTodo(todoItem: TodoItem)
    func deleteTodo(id: String)
    func addTodoItem(todoItem: TodoItem)
    func updateTodoList(todoList: [TodoItem])
}

