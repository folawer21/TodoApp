//
//  HeaderView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct HeaderView: View {
    var count: Int
    @Binding var isShown: Bool
    var body: some View {
        HStack{
            Text("Выполнено - \(count)")
                .font(.subheadline)
            
            Spacer()
            
            Button(action: {
                
            },
                   label: {
                Text(isShown == true ? "Скрыть": "Показать")
            })
            
            Button("Показать"){
                print("Show button tapped")
            }
            .font(.subheadline)
            
        }
        .textCase(nil)
    }
}

//#Preview {
//    HeaderView()
//}
