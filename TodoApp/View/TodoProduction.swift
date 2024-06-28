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
    @State var selectedImportance: Importance = .regular
    var body: some View {
        NavigationStack{
            List{
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
                                Text("Сделать до")
                                Spacer()
                                
                            }
                        }
                }
            }
               
//            .navigationTitle("Дело")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar{
//                ToolbarItem(placement: .topBarLeading){
//                    Button("Отменить"){
////                            dismiss()
//                    }
//                }
//                
//                ToolbarItem(placement: .topBarTrailing){
//                    Button("Сохранить"){
//                        
//                    }
//                    .disabled(text == "")
//                }
//            }
        }

    }
        
}

#Preview {
    TodoProduction(/*isReadyToSave: false*/ selectedImportance: Importance.important)
}
