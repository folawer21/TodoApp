//
//  MainView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

//Добавить кнопку показать
struct MainView: View {
    var taskManager: TaskManager = TaskManager()
    var body: some View {
        NavigationView(){
            ZStack{
                TodoList(taskManager: taskManager)
                    .navigationTitle("Мои дела").navigationBarTitleDisplayMode(.inline)
                    
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading){
                            NavigationLink(){
                                CalendarWrapper()
                                    .navigationTitle("Мои дела")
                            } label: {
                                Image(systemName: "calendar")
                            }
                        }
                    })
                
            }
        }
    }
}

#Preview {
    MainView()
}
