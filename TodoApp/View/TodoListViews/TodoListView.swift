//
//  MyTodo.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI
import CocoaLumberjackSwift

struct TodoList: View {
    @State var isMakeNewShown: Bool = false
    @State var isShown: Bool = false
    @StateObject var taskManager: TaskManager
    var body: some View {
            List {
                Section(content: {
                        ForEach( taskManager.todoitems, id: \.id) { item in
                            if !isShown && item.isDone == true {
                            } else {
                                TodoRow(
                                    id: item.id,
                                    isCompleted: item.isDone,
                                    importance: item.importance,
                                    itemText: item.text,
                                    color: Color(hex: item.color) ,
                                    isHasDeadline: item.deadline != nil ? true : false,
                                    deadline: item.deadline ?? Date(),
                                    categoty: Color(hex: item.category) 
                                )
                                    .environmentObject(taskManager)
                            }
                }
                NewItemRowView()
                    .onTapGesture(perform: { _ in
                        isMakeNewShown.toggle()
                        DDLogInfo("Item creating screen showed")
                    })
            }
                , header: {
                    HStack {
                        Text("Выполнено - \(taskManager.getDoneCount())")
                            .font(.subheadline)
                        Spacer()
                        Button(action: {
                            showButtonTapped()
                        },
                               label: {
                            Text(isShown == true ? "Скрыть": "Показать")
                        })
                        .font(.subheadline)
                    }
                    .textCase(nil)
                })
            }
            .multilineTextAlignment(.leading)
            .overlay(alignment: .bottom) {
                plusButton
            }
            .sheet(isPresented: $isMakeNewShown) {
                TodoProduction(
                    taskManager: taskManager,
                    toggleOn: false,
                    deadline: Calendar.current.date(
                        byAdding: .day,
                        value: 1,
                        to: Date()
                    ) ?? Date()
                    ,
                    selectedBrightness: 1.0,
                    selectedColor: .blue,
                    selectedCategory: .red
                )
            }
    }
    var plusButton: some View {
       Button(action: {
           DDLogInfo("Item creating screen showed")
           isMakeNewShown.toggle()
        },
               label: {
            Image(systemName: "plus")
                .fontWeight(.bold)
                .imageScale(.large)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(
                    Color.blue.shadow(
                        .drop(
                            color: .black.opacity(0.25),
                            radius: 7,
                            x: 0,
                            y: 10
                        )
                    ),
                    in: .circle
                )
        })
    }
    private func showButtonTapped() {
        isShown.toggle()
    }
}

#Preview {
    TodoList(taskManager: TaskManager())
}
