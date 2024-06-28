//
//  MyTodo.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct TodoList: View {
    @State var isMakeNewShown: Bool = false
    var body: some View {
            List(){
                Section(header: HeaderView()){
                    ForEach(1..<5, content: {_ in TodoRow(isCompleted: false, importance: .regular)})
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
                TodoProduction()
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
    TodoList()
}
