//
//  TodoNetworkStore.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 20.07.2024.
//

import Foundation
import Combine

final class TodoNetworkStore: NetworkStore {
    static let shared = TodoNetworkStore(service: NetworkService())
    private var isDirty: Bool = false
    init(service: NetworkServiceProtocol) {
        self.service = service
        self.todos = []
    }
    private var service: NetworkServiceProtocol
    @Published private(set) var todos: [TodoItem]
    private func checkIfAlreadyHere(id: String) -> Int? {
        guard let index = todos.firstIndex(where: { $0.id == id}) else {
            return nil
        }
        return index
    }
    private func getTodo(id: String) -> TodoItem? {
        return todos.first(where: {$0.id == id })
    }
    private func setTodos(todos: [TodoItem]) {
        self.todos = todos
    }
    private func setTodo(todo: TodoItem) {
        guard let firstIndex = todos.firstIndex(where: {$0.id == todo.id}) else {
            return
        }
        todos[firstIndex] = todo
    }
    private func removeTodo(id: String) {
        todos.removeAll(where: {$0.id == id})
    }
    private func appendTodo(todoItem: TodoItem) {
        todos.append(todoItem)
    }
    func getTodos() {
        Task {
            do {
                let todos = try await service.getTodoList()
                setTodos(todos: todos)
                isDirty = false
                if isDirty {
                    getTodos()
                }
            } catch {
                isDirty = true
            }
        }
    }
    func getTodoById(id: String) -> TodoItem? {
        Task {
            do {
                let todo = try await service.getTodoItemById(id: id )
                setTodo(todo: todo)
                if isDirty {
                    getTodos()
                }
            } catch {
                isDirty = true
            }
        }
        return getTodo(id: id)
    }
    func changeTodo(todoItem: TodoItem) {
        setTodo(todo: todoItem)
        Task {
            do {
                let _ = try await service.changeTodoItemById(todoItem: todoItem)
                if isDirty {
                    getTodos()
                }
            } catch {
                isDirty = true
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
                if isDirty {
                    getTodos()
                }
            } catch {
                isDirty = true
            }
        }
    }
    func addTodoItem(todoItem: TodoItem) {
        if let index = checkIfAlreadyHere(id: todoItem.id) {
            return
        }
        appendTodo(todoItem: todoItem)
        Task {
            do {
                try await service.addTodoItem(todoItem: todoItem)
                if isDirty {
                    getTodos()
                }
            } catch {
                isDirty = true
            }
        }
    }
    func updateTodoList(todoList: [TodoItem]) {
        setTodos(todos: todos)
        Task {
            do {
                let todos = try await service.updateTodoList(todoList: todoList)
                setTodos(todos: todos)
                if isDirty {
                    getTodos()
                }
            } catch {
                isDirty = true
            }
        }
    }
}
