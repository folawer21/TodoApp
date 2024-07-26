//
//  TodoItemSwiftData.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 26.07.2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
final class TodoItemSwiftData {
    @Attribute(.unique) let id: String
    let text: String
    let importance: Importance
    let deadline: Date?
    let isDone: Bool
    let color: Color
    let createdAt: Date
    let changedAt: Date?
    let category: Color
    init(from item: TodoItem) {
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
    init(from item: TodoItem, changedAt: Date) {
        self.id = item.id
        self.text = item.text
        self.importance = item.importance
        self.deadline = item.deadline
        self.isDone = item.isDone
        self.color = item.color
        self.createdAt = item.createdAt
        self.changedAt = changedAt
        self.category = item.category
    }
}
