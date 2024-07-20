//
//  TaskManager.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//

import Foundation
import FileCache
import CocoaLumberjackSwift
import Combine
final class TaskManager: ObservableObject {
    private var fileCache = FileCache<TodoItem>()
    private let store = TodoNetworkStore.shared
    @Published private(set) var todoitems: [TodoItem]
    private var cancellables = Set<AnyCancellable>()
    var uncompletedTodoitems: [TodoItem] {
            todoitems.filter {$0.isDone == false}
    }
    let dateFormatter = DateFormatter()
    let outputFormatter = DateFormatter()

    init(items: [TodoItem] = [] ) {
        self.todoitems = items
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        TodoNetworkStore.shared.$todos
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] newTodos in
                        self?.todoitems = newTodos
                    }
                    .store(in: &cancellables)
        store.getTodos()
    }
    func checkIfAlreadyHere(id: String) -> Int? {
        guard let index = todoitems.firstIndex(where: { $0.id == id}) else {
            return nil
        }
        DDLogWarn("Todo item is already added")
        return index
    }
    func setItems(items: [TodoItem]) {
        DDLogInfo("Todo's list setted")
        store.updateTodoList(todoList: items)
    }
    func addNewItem(item: TodoItem) {
        if let _ = checkIfAlreadyHere(id: item.id) {
            DDLogWarn("Todo didn't added because item with id = \(item.id) is already here")
            store.changeTodo(todoItem: item)
        } else {
            DDLogInfo("New todo added")
            store.addTodoItem(todoItem: item)
        }
    }
    func removeItem(item: TodoItem) {
        DDLogInfo("Todo with id = \(item.id) removed")
        store.deleteTodo(id: item.id)
    }
    func removeItemById(id: String) {
        if id == "" {
            DDLogWarn("Id is empty. Todo item isn't removed")
        }
        DDLogInfo("Todo with id = \(id) removed")
        store.deleteTodo(id: id)
    }
    func getDoneCount() -> Int {
        return todoitems.filter {
            $0.isDone == true
        }.count
    }
    func isComplete(id: String) -> Bool {
        guard let index = todoitems.firstIndex(where: { $0.id == id}) else {
            DDLogWarn("Item with id = \(id) is not found")
            return false
        }
        let item = todoitems[index]
        return item.isDone
    }
    func makeComplete(id: String, complete: Bool) {
        guard let index = todoitems.firstIndex(where: { $0.id == id}) else {
            DDLogWarn("Item with id = \(id) is not found")
            return
        }
        let old = todoitems[index]
        let new = TodoItem(
            id: old.id,
            text: old.text,
            color: old.color,
            importance: old.importance,
            deadline: old.deadline,
            isDone: complete,
            createdAt: old.createdAt,
            changedAt: Date(),
            categorty: old.category
        )
        store.changeTodo(todoItem: new)
        DDLogInfo("Todo with id = \(id) is completed = \(complete)")
    }
    func getCollectionByDate() -> [String: [TodoItem]] {
        let result = collectionByDate()
        return result
    }
    func getDatesCollection() -> [String] {
        let result = getStringDates()
        return result
    }
    private func collectionByDate() -> [String: [TodoItem]] {
        var result: [String: [TodoItem]] = [:]
        for todoitem in todoitems {
            guard let date = todoitem.deadline else {
                if result.keys.contains("Другое") {
                    result["Другое"]?.append(todoitem)
                } else {
                    result["Другое"] = [todoitem]
                }
                continue
            }
            let stringDate = outputFormatter.string(from: date)
            if result.keys.contains(stringDate) {
                result[stringDate]?.append(todoitem)
            } else {
                result[stringDate] = [todoitem]
            }
        }
        return result
    }
    private func getStringDates() -> [String] {
        var result: [String]  = []
        var flag = false
        for todoitem in todoitems {
            guard let date = todoitem.deadline else {
                    flag = true
                continue}
            let string = outputFormatter.string(from: date)
            if !result.contains(string) {
                result.append(string)
            }
        }
        if flag {
            result.append("Другое")
        }
        return result
    }
}
