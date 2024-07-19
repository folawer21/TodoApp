//
//  TodoNetworkStore.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 20.07.2024.
//

import Foundation

final class TodoNetworkStore: ObservableObject, NetworkStore {
    let shared = TodoNetworkStore(service: NetworkService())
    init(service: NetworkServiceProtocol) {
        self.service = service
        self.todos = []
    }
    private var service: NetworkServiceProtocol
    @Published var todos: [TodoItem]
    
    func checkIfAlreadyHere(id: String) -> Int? {
        guard let index = todos.firstIndex(where: { $0.id == id}) else {
            return nil
        }
        return index
    }
    func getTodo(id: String) -> TodoItem? {
        return todos.first(where: {$0.id == id })
    }
    func setTodos(todos: [TodoItem]) {
        self.todos = todos
    }
    func setTodo(todo: TodoItem) {
        guard let firstIndex = todos.firstIndex(where: {$0.id == todo.id}) else {
            return
        }
        todos[firstIndex] = todo
    }
    func removeTodo(id: String){
        todos.removeAll(where: {$0.id == id})
    }
    func appendTodo(todoItem: TodoItem){
        todos.append(todoItem)
    }
    func getTodos() -> [TodoItem] {
        Task {
            do {
                let todos = try await service.getTodoList()
                setTodos(todos: todos)
            } catch {
                print(error)
            }
        }
        return todos
    }
    func getTodoById(id: String) -> TodoItem? {
        Task {
            do {
                let todo = try await service.getTodoItemById(id: id )
            } catch {
                print(error)
            }
        }
        return getTodo(id: id)
    }
    func changeTodo(todoItem: TodoItem) {
        setTodo(todo: todoItem)
        Task {
            do {
                let _ = try await service.changeTodoItemById(todoItem: todoItem)
                
            } catch {
                print(error)
            }
        }
    }
    func deleteTodo(id: String) {
        guard let index = checkIfAlreadyHere(id: id) else {
            return
        }
        removeTodo(id: id)
        Task {
            do {
                let _ = try await service.deleteTodoItemById(id: id)
                
            } catch {
                print(error)
            }
        }
    }
    func addTodoItem(todoItem: TodoItem) {
        if let index = checkIfAlreadyHere(id: todoItem.id) {
            return
        }
        appendTodo(todoItem: todoItem)
        Task{
            do {
                try await service.addTodoItem(todoItem: todoItem)
            } catch {
                print(error)
            }
        }
    }
    func updateTodoList(todoList: [TodoItem]){
        setTodos(todos: todos)
        Task{
            do {
                let todos = try await service.updateTodoList(todoList: todoList)
                setTodos(todos: todos)
            } catch {
                print(error)
            }
        }
    }
    
}
