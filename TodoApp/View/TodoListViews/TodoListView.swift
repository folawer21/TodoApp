//
//  MyTodo.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct TodoList: View {
    @State var isMakeNewShown: Bool = false
    @StateObject var taskManager: TaskManager
    var body: some View {
            List(){
                Section(header: HeaderView(count: taskManager.getDoneCount())){
                    ForEach(taskManager.todoitems, id: \.id) { item in
                        TodoRow(
                            id: item.id,
                            isCompleted: item.isDone,
                            importance: item.importance,
                            itemText: item.text,
                            color: item.color,
                            isHasDeadline: item.deadline != nil ? true : false,
                            deadline: item.deadline ?? Date()
                          
                        )
                            .environmentObject(taskManager)
                           
                    }
                    NewItemRowView()
                        .onTapGesture(perform:{ _ in 
                            isMakeNewShown.toggle()
                        })
                        
                }
           
            }
            .multilineTextAlignment(.leading)
            .overlay(alignment: .bottom){
                plusButton
            }
            .sheet(isPresented: $isMakeNewShown){
                TodoProduction(
                    taskManager:taskManager,
                    toggleOn: false,
                    deadline: Calendar.current.date(
                        byAdding: .day,
                        value: 1,
                        to: Date()
                    ) ?? Date()
                    ,
                    selectedBrightness: 1.0,
                    selectedColor: .blue
                )
            }
            
            
    }
    
   
    var plusButton: some View {
       Button(action: {
           isMakeNewShown.toggle()
        },
               label: {
            Image(systemName: "plus")
                .fontWeight(.bold)
                .imageScale(.large)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Color.blue.shadow(.drop(color: .black.opacity(0.25), radius: 7, x: 0 , y: 10)), in: .circle)

        })
        
    }
    
    
    func newButtonTapped(){
        print("tapped")
    }
}

#Preview {
    TodoList(taskManager: TaskManager())
}
