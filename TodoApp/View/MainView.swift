//
//  MainView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct MainView: View {
    var taskManager: TaskManager = TaskManager()
    var body: some View {
        NavigationView(){
            ZStack{
                TodoList(taskManager: taskManager)
                    .navigationTitle("Мои дела").navigationBarTitleDisplayMode(.large)
            }
            
        }
    }
}

#Preview {
    MainView()
}
