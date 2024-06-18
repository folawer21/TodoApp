//
//  TodoItem.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 18.06.2024.
//

import Foundation

enum Importance: String{
    case important = "important"
    case regular = "regular"
    case unimportant = "unimportant"
}

struct TodoItem{
    let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isDone: Bool
    let createdAt: Date
    let changedAt: Date?
    
    init(id: String = UUID().uuidString , text: String, importance: Importance, deadline: Date?, isDone: Bool, createdAt: Date, changedAt: Date?) {
        self.id = id
        self.text = text
        self.importance = importance
        self.deadline = deadline
        self.isDone = isDone
        self.createdAt = createdAt
        self.changedAt = changedAt
    }
}

extension TodoItem{
    static func parse(json: Any) -> TodoItem?{
        do {
            guard let jsonData = json as? Data else {
                return nil
            }
            guard let jsonObject = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {return nil}
            guard let id = jsonObject["id"] as? String else {return nil}
            guard let text = jsonObject["text"] as? String else {return nil}
            let importanceRawValue = jsonObject["importance"] as? String ?? Importance.regular.rawValue
            guard let importance = Importance(rawValue: importanceRawValue) else {return nil}
            guard let deadline = jsonObject["deadline"] as? Date? else {return nil}
            guard let isDone = jsonObject["isDone"] as? Bool else {return nil}
            let createdAt = Date()
            let changedAt: Date? = nil
            let todoItem = TodoItem(id: id, text: text , importance: importance, deadline: deadline, isDone: isDone, createdAt: createdAt, changedAt: changedAt)
            return todoItem
        }catch{
            print(error)
            return nil
        }
    }
    
    var json: Any{
        var jsonDict = [String: Any]()
        jsonDict["id"] = self.id
        jsonDict["text"] = self.text
        if self.importance != .regular{
            jsonDict["importance"] = self.importance.rawValue
        }
        if let deadline = self.deadline{
            jsonDict["deadline"] = self.deadline
        }
        jsonDict["isDone"] = self.isDone
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDict)
            return jsonData
        }catch{
            print(error)
            return Data()
        }
    }
}
