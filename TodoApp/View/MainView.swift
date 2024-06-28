//
//  MainView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView(){
            ZStack{
                TodoList()
                    .navigationTitle("Мои дела").navigationBarTitleDisplayMode(.large)
            }
            
        }
    }
}

#Preview {
    MainView()
}
