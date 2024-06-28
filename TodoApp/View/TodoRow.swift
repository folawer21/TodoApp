//
//  TodoRow.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct TodoRow: View {
    var id: String
    @State var isCompleted: Bool
    @State var importance: Importance
    @State var itemText: String
    @State var isScreenShown: Bool = false
    @State var isHasDeadline: Bool 
    @State var deadline: Date?
    
    @EnvironmentObject var taskManager: TaskManager
    var body: some View {
        HStack{
            CompleteButton(isCompleted: $isCompleted, importance: $importance)
                .onTapGesture(perform: completeButtonTapped)
            VStack(alignment: .leading){
                HStack{
                    if importance == .important {
                        Image(systemName: "exclamationmark.2")
                            .foregroundColor(.red)
                            .fontWeight(.bold)
                    }
                    Text(itemText)
                        .font(.system(size: 17))
                }
                if deadline != nil{
                    HStack{
                        Image(systemName: "calendar")
                        Text(formatter.string(from: deadline ?? Date.now))
                    }
                    .font(.footnote)
                    .foregroundStyle(Color.gray)
                }
            }
            Spacer()
            Button(action: {isScreenShown.toggle()},
                   label: {
                Image(systemName: "chevron.right")
            })
            .foregroundColor(.secondary)
        }
        .sheet(isPresented: $isScreenShown){
            TodoProduction(
                id: id,
                text: itemText,
                toggleOn: isHasDeadline,
                deadline: deadline ?? (Calendar.current.date(
                            byAdding: .day,
                            value: 1,
                            to: Date()
                        ) ?? Date()) ,
                selectedImportance: importance
                )
            .environmentObject(taskManager)
        }
        .swipeActions(edge: .leading){
            completeButton
        }
        
        .swipeActions(edge: .trailing){
            deleteButton
            infoButton
        }
       
    
     
    }
    var completeButton: some View {
        Button(
            action: {isCompleted.toggle()},
            label: {
                Image(systemName: "checkmark.circle")
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.green)
                    .background(.white)
                    .imageScale(.large)
                    .fontWeight(.bold)
            }
        )
        .tint(.green)
    }
        
    var deleteButton: some View {
         Button(
             action: {
                 taskManager.removeItemById(id: id)
             },
             label: {
                 Image(systemName: "trash.fill")
             }
         )
         .tint(.red)
     }
     
     var infoButton: some View {
         Button(
            action: {isScreenShown.toggle()},
             label: {
                 Image(systemName: "info.circle.fill")
             }
         )
     }
    var backgroundColor: Color{
        .clear
    }
    var formatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    func completeButtonTapped(){
        isCompleted.toggle()
    }
    
    func showRefactorView(){
        isCompleted.toggle()
    }
}

//#Preview {
//    TodoRow(isCompleted: false, importance: .regular)
//}
