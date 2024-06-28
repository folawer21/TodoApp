//
//  HeaderView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack{
            Text("Выполнено - ")
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

#Preview {
    HeaderView()
}
