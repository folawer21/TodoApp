//
//  SwiftDataManager.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.07.2024.
//

import Foundation
import SwiftData


final class SwiftDataManager {
    let container: ModelContainer
    let context: ModelContext
    init() throws {
        self.container = try ModelContainer(for: TodoItemSwiftData.self, configurations: ModelConfiguration())
        self.context = ModelContext(self.container)
    }

    func insert(_ todoItem: TodoItem) {
        let todoItemSD = TodoItemSwiftData(from: todoItem)
        context.insert(todoItemSD)
    }
    func fetch() -> [TodoItem] {
        do {
            let data = try context.fetch(FetchDescriptor<TodoItemSwiftData>())
            return data.map{TodoItem(from: $0)}
        } catch {
            print(error)
            return []
        }
    }
    func delete(_ todoItem: TodoItem) {
        let todoItemSD = TodoItemSwiftData(from: todoItem)
        context.delete(todoItemSD)
    }
    func update( _ todoItem: TodoItem) {
        guard let oldTodoItemSD = get(todoItem.id) else {
            let newTodoItemSD = TodoItemSwiftData(from: todoItem, changedAt: Date())
            context.insert(newTodoItemSD)
            return
        }
        let newTodoItemSD = TodoItemSwiftData(from: todoItem, changedAt: Date())
        context.delete(oldTodoItemSD)
        context.insert(newTodoItemSD)
    }
    func get(_ id: String) -> TodoItemSwiftData? {
            let predicate = #Predicate<TodoItemSwiftData> { $0.id == id }
            var descriptor = FetchDescriptor(predicate: predicate)
            descriptor.fetchLimit = 1
            do {
                let item = try context.fetch(descriptor)
                return item[0]
            } catch {
                return nil
            }
        }
}
