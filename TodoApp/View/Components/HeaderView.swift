//
//  HeaderView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct HeaderView: View {
    var count: Int
    var body: some View {
        HStack{
            Text("Выполнено - \(count)")
                .font(.subheadline)
            
            Spacer()
            
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
