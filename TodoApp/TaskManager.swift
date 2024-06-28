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
            print("Changing")
            print(todoitems[index])
            todoitems[index] = item
            print(todoitems[index])
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
    
}
