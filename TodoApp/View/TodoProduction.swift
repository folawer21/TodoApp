//
//  CreateItem.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//

import SwiftUI

struct TodoProduction: View {
//    @State var isReadyToSave: Bool
    @State var text: String = ""
    @State var toggleOn: Bool = false
    @State var deadline: Date = Calendar.current.date(
        byAdding: .day,
        value: 1,
        to: Date()
    ) ?? Date()
    @State var calendarIsShown: Bool = false
    @State var selectedImportance: Importance = .regular
    
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
                    VStack(alignment: .leading){
                        HStack{
                            Text("Важность")
                            Spacer()
                            CustomSegmentedControl(selectedImportance: $selectedImportance)
//                                .frame(width: 156 , height: 36)
                        }
                        .frame(height: 56)
                        Divider()
                        HStack{
                            VStack(alignment: .leading) {
                                Text("Сделать до")
                                if toggleOn {
                                    Button(action: {
                                        calendarIsShown.toggle()
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
                            Divider()
                            DatePicker("", selection: $deadline,displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .environment(\.locale, Locale(identifier: "ru_RU"))
                                .animation(.bouncy)
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
//                            dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing){
                    Button("Сохранить"){
                        
                    }
                    .disabled(text == "")
                }
            }
        }

    }
        
}

#Preview {
    TodoProduction(/*isReadyToSave: false*/ selectedImportance: Importance.important)
}

