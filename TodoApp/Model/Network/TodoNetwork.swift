//
//  TodoNetwork.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 20.07.2024.
//

import Foundation

struct TodoNetwork: Codable {
    let id: String
    let text: String
    let importance: String
    let deadline: Int64?
    let done: Bool
    let color: String?
    let files: [String]?
    let createdAt: Int64
    let changedAt: Int64
    let lastUpdatedBy: String
    enum CodingKeys: String, CodingKey {
        case id
        case text
        case importance
        case deadline
        case done
        case color
        case files
        case createdAt = "created_at"
        case changedAt = "changed_at"
        case lastUpdatedBy = "last_updated_by"
    }
    init(from item: TodoItem) {
        self.id = item.id
        self.text = item.text
        self.importance = item.importance.rawValue
        if let deadline = item.deadline {
            self.deadline = Int64(deadline.timeIntervalSince1970)
        } else {
            self.deadline = nil
        }
        self.files = nil
        self.done = item.isDone
        self.color = item.color
        self.createdAt = Int64(item.createdAt.timeIntervalSince1970)
        self.changedAt = Int64((item.changedAt ?? item.createdAt).timeIntervalSince1970)
        self.lastUpdatedBy = NetworkDefault.deviceId
    }
}
