//
//  TodoItem.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 16.06.2024.
//

import SwiftUI
import FileCache

enum Importance: String, Codable{
    case important = "important"
    case regular = "regular"
    case unimportant = "unimportant"
}

struct TodoItem: Identifiable, JSONableItem {
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isDone: Bool
    let color: Color
    let createdAt: Date
    let changedAt: Date?
    let category: Color
    init(
        id: String = UUID().uuidString,
        text: String,
        color: Color,
        importance: Importance,
        deadline: Date?,
        isDone: Bool,
        createdAt: Date,
        changedAt: Date?,
        categorty: Color
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
    init(todoNetwork: TodoNetwork){
        self.id = String(describing: todoNetwork.id)
        self.text = todoNetwork.text
        self.importance = todoNetwork.importance
        self.deadline = todoNetwork.deadline
        self.isDone = todoNetwork.done
        self.color = Color(hex: todoNetwork.color ?? "#FFFFFF")
        self.createdAt = todoNetwork.createdAt
        self.changedAt = todoNetwork.changedAt
        self.category = Color.clear
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
        guard let color = jsonObject["color"] as? Color else {return nil}
        guard let category = jsonObject["category"] as? Color else {return nil}
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
