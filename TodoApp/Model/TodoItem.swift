//
//  TodoItem.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 16.06.2024.
//

import SwiftUI
import FileCache

enum Importance: String, Codable {
    case important = "important"
    case regular = "basic"
    case unimportant = "low"
}

struct TodoItem: Identifiable, JSONableItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isDone: Bool
    let color: String
    let createdAt: Date
    let changedAt: Date?
    let category: String
    init(
        id: String = UUID().uuidString,
        text: String,
        color: String,
        importance: Importance,
        deadline: Date?,
        isDone: Bool,
        createdAt: Date,
        changedAt: Date?,
        categorty: String
    ) {
        self.id = id
        self.text = text
        self.color = color
        self.importance = importance
        self.deadline = deadline
        self.isDone = isDone
        self.createdAt = createdAt
        self.changedAt = changedAt
        self.category = categorty
    }
    init(todoNetwork: TodoNetwork) {
        self.id = String(describing: todoNetwork.id)
        self.text = todoNetwork.text
        self.importance = Importance(rawValue: todoNetwork.importance) ?? .regular
        if let deadline = todoNetwork.deadline {
            self.deadline = Date(timeIntervalSince1970: Double(deadline))
        } else {
            self.deadline = nil
        }
        self.isDone = todoNetwork.done
        self.color = todoNetwork.color ?? "#FFFFFF"
        self.createdAt = Date(timeIntervalSince1970: Double(todoNetwork.createdAt))
        self.changedAt = Date(timeIntervalSince1970: Double(todoNetwork.changedAt))
        self.category = Color.clear.hexString()
    }
    init(from item: TodoItemSwiftData) {
        self.id = item.id
        self.text = item.text
        self.importance = item.importance
        self.deadline = item.deadline
        self.isDone = item.isDone
        self.color = item.color
        self.createdAt = item.createdAt
        self.changedAt = item.changedAt
        self.category = item.category
    }
}

extension TodoItem {
static func parse(json: Any) -> TodoItem? {
        guard let jsonObject = json as? [String: Any] else {return nil}
        guard let id = jsonObject["id"] as? String else {return nil}
        guard let text = jsonObject["text"] as? String else {return nil}
        let importanceRawValue = jsonObject["importance"] as? String ?? Importance.regular.rawValue
        guard let importance = Importance(rawValue: importanceRawValue) else {return nil}
        guard let deadline = jsonObject["deadline"] as? Date? else {return nil}
        guard let isDone = jsonObject["isDone"] as? Bool else {return nil}
        guard let color = jsonObject["color"] as? String else {return nil}
        guard let category = jsonObject["category"] as? String else {return nil}
        let createdAt = Date()
        let changedAt: Date? = nil
    let todoItem = TodoItem(
        id: id,
        text: text,
        color: color,
        importance: importance,
        deadline: deadline,
        isDone: isDone,
        createdAt: createdAt,
        changedAt: changedAt,
        categorty: category
    )
        return todoItem
    }
    var json: Any {
        var jsonDict = [String: Any]()
        jsonDict["id"] = self.id
        jsonDict["text"] = self.text
        if self.importance != .regular {
            jsonDict["importance"] = self.importance.rawValue
        }
        if let deadline = self.deadline {
            jsonDict["deadline"] = deadline
        }
        jsonDict["color"] = color
        jsonDict["isDone"] = self.isDone
        jsonDict["category"] = category
        return jsonDict
    }
}
