//
//  MainView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

//Добавить кнопку показать
//Проблема в обновлении даты второго экрана
//self.present(hostingController,animated: true)

struct MainView: View {
    var taskManager: TaskManager = TaskManager()
    var body: some View {
        NavigationView(){
            ZStack{
                TodoList(taskManager: taskManager)
                    .navigationTitle("Мои дела").navigationBarTitleDisplayMode(.large)
                    
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading){
                            NavigationLink(){
                                CalendarWrapper(taskManager: taskManager)
                                    .navigationTitle("Мои дела").navigationBarTitleDisplayMode(.inline)
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
