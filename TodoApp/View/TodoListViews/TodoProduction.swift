//
//  CreateItem.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//

import SwiftUI

protocol TodoProductionDelegate: AnyObject{
    func screenWasClosen()
}

struct TodoProduction: View {
    var taskManager: TaskManager
    weak var delegate: TodoProductionDelegate?
    @State var id: String?
    @State var text: String = ""
    @State var toggleOn: Bool
    @State var deadline: Date
    @State var calendarIsShown: Bool = false
    @State var colorPickerIsShown: Bool = false
    @State var selectedBrightness: Double = 1.0
    @State var selectedColor: Color
    @State var selectedImportance: Importance = .regular
    @State var selectedCategory: Color
    
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
                    Group(){
                        HStack{
                            Text("Важность")
                            Spacer()
                            CustomSegmentedControl(selectedImportance: $selectedImportance)
                        }
                        HStack{
                            Text("Категория")
                            Spacer()
                            CategoryPicker(selectedColor: $selectedCategory)
                            
                        }
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
                        if calendarIsShown && toggleOn{
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
                        taskManager.removeItemById(id: id ?? "" )
                        self.delegate?.screenWasClosen()
                        self.presentationMode.wrappedValue.dismiss()
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
                        self.delegate?.screenWasClosen()
                        self.presentationMode.wrappedValue.dismiss()
                        
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Сохранить"){
                        
                        let item = TodoItem(
                            id: id ?? UUID().uuidString,
                            text: text,
                            color: selectedColor.opacity(selectedBrightness),
                            importance: selectedImportance,
                            deadline: toggleOn ? deadline : nil,
                            isDone: false,
                            createdAt: Date(),
                            changedAt: nil,
                            categorty: selectedCategory
                        )
                        taskManager.addNewItem(item: item)
                        self.delegate?.screenWasClosen()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .disabled(text == "")
                }
            }
        }
       

    }
        
}
//
//#Preview {
//    TodoProduction(taskManager: TaskManager(), toggleOn: false, deadline: Date(), selectedColor: .blue,selectedCategory: .red)
//}

