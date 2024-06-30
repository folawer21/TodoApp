//
//  TaskManager.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//

import Foundation

final class TaskManager: ObservableObject{
    @Published private(set) var todoitems: [TodoItem]
    
    init(items: [TodoItem] = [] ){
        self.todoitems = items
    }
    
    func checkIfAlreadyHere(id: String) -> Int? {
        guard let index = todoitems.firstIndex(where: { $0.id == id}) else {
            return nil
        }
        return index
    }
    
    func setItems(items: [TodoItem]){
        todoitems = items
    }
    
    func addNewItem(item: TodoItem){
        if let index = checkIfAlreadyHere(id: item.id){
            todoitems[index] = item
        }
        else{
            todoitems.append(item)
        }
    }
    
    func removeItem(item: TodoItem){
        todoitems.removeAll(where: {$0.id == item.id})
    }
    
    func removeItemById(id: String){
        todoitems.removeAll(where: {$0.id == id})
    }
    
    func getDoneCount() -> Int{
        return todoitems.filter{
            $0.isDone == true
        }.count
    }
    
    func makeComplete(id:String, complete:Bool){
        guard let index = todoitems.firstIndex(where: { $0.id == id}) else {
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
            changedAt: old.changedAt
        )
        todoitems[index] = new
    }
}
