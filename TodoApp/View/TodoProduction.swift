//
//  CreateItem.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//

import SwiftUI

struct TodoProduction: View {
//    @State var isReadyToSave: Bool
    @EnvironmentObject var taskManager: TaskManager
    @State var id: String?
    @State var text: String = ""
    @State var toggleOn: Bool
    @State var deadline: Date = Calendar.current.date(
        byAdding: .day,
        value: 1,
        to: Date()
    ) ?? Date()
    @State var calendarIsShown: Bool = false
    @State var colorPickerIsShown: Bool = false
    
    @State var selectedBrightness: Double = 1.0
    @State var selectedColor: Color = .blue
    @State var selectedImportance: Importance = .regular
    
    @Environment(\.presentationMode) var presentationMode

    var formatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM YYYY"
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Что надо сделать?", text: $text, axis: .vertical)
                        .lineLimit(4...)
                }
                Section{
                    Group(/*alignment: .leading*/){
                        HStack{
                            Text("Важность")
                            Spacer()
                            CustomSegmentedControl(selectedImportance: $selectedImportance)
                        }
//                        .frame(height: 56)
//                        Divider()
                        HStack{
                            Text("Цвет")
                            Spacer()
                            Button(action: {
                                withAnimation{
                                    colorPickerIsShown.toggle()
                                }
                            }, label: {
                                Circle()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(selectedColor)
                                    .brightness(1 - selectedBrightness)
                            })
                        }
                       
                       
                        if colorPickerIsShown{
                            CustomColorPickerView(selectedColor: $selectedColor, brightness: $selectedBrightness)
                        }
                       
                        
                        HStack{
                            VStack(alignment: .leading) {
                                Text("Сделать до")
                                if toggleOn {
                                    Button(action: {
                                        withAnimation{
                                            calendarIsShown.toggle()
                                        }
                                    },
                                    label: {
                                        Text(formatter.string(from: deadline))
                                            .font(.footnote)
                                            .fontWeight(.bold)
                                            
                                    })
                                }
                            }
                            
                            Spacer()
                            Toggle("",isOn: $toggleOn)
                            
                        }
//                        .frame(height: 56)
                        if calendarIsShown && toggleOn{
//                            Divider()
                            DatePicker("", selection: $deadline,displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .environment(\.locale, Locale(identifier: "ru_RU"))
                                .animation(.snappy)
                                .transition(.opacity)
                             
                        }
                    }
                }
                
                Section(){
                    Button(action: {
                        toggleOn.toggle()
                    },
                           label: {
                        HStack{
                            Spacer()
                            Text("Удалить")
                                .foregroundColor(text != "" ? .red : .secondary)
                            Spacer()
                        }
                        
                            
                    })
                    .cornerRadius(16)
                    .frame(height: 36)
                    .disabled(text == "")
                   
                    
                }
            }
               
            .navigationTitle("Дело")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .topBarLeading){
                    Button("Отменить"){
                        self.presentationMode.wrappedValue.dismiss()
//                            dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Сохранить"){
                        let item = TodoItem(
                            id: id ?? UUID().uuidString,
                            text: text,
                            importance: selectedImportance,
                            deadline: deadline,
                            isDone: false,
                            createdAt: Date(),
                            changedAt: nil
                        )
                        taskManager.addNewItem(item: item)
                        self.presentationMode.wrappedValue.dismiss()

                    }
                    .disabled(text == "")
                }
            }
        }
       

    }
        
}

//#Preview {
//    TodoProduction(/*isReadyToSave: false*/ selectedImportance: Importance.important, task)
//}
//
