//
//  TaskManager.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//

import Foundation

final class TaskManager: ObservableObject{
    @Published private(set) var todoitems: [TodoItem]
    let dateFormatter = DateFormatter()
    let outputFormatter = DateFormatter()

    init(items: [TodoItem] = [] ){
        self.todoitems = items
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
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
    
    func isComplete(id: String) -> Bool{
        guard let index = todoitems.firstIndex(where: { $0.id == id}) else {
            return false
        }
        let item = todoitems[index]
        return item.isDone
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
            changedAt: Date(),
            categorty: old.category
        )
        todoitems[index] = new
    }
    
    func getCollectionByDate() -> [String: [TodoItem]]{
        let result = collectionByDate()
        return result
    }
    
    func getDatesCollection() -> [String]{
        let result = getStringDates()
        return result
    }
    
    private func collectionByDate() -> [String: [TodoItem]]{
        var result: [String : [TodoItem]] = [:]
        for todoitem in todoitems {
            guard let date = todoitem.deadline else {
                if result.keys.contains("Другое"){
                    result["Другое"]?.append(todoitem)
                }else{
                    result["Другое"] = [todoitem]
                }
                continue
            }
            let stringDate = outputFormatter.string(from: date)
            if result.keys.contains(stringDate){
                result[stringDate]?.append(todoitem)
            }else{
                result[stringDate] = [todoitem]
            }
        }
        return result
    }
    
    private func getStringDates() -> [String]{
        var result: [String]  = []
        var flag = false
        for todoitem in todoitems {
            guard let date = todoitem.deadline else {
                    flag = true
                continue}
            let string = outputFormatter.string(from: date)
            if !result.contains(string){
                result.append(string)
            }
        }
        if flag{
            result.append("Другое")
        }
        return result
    }

}
