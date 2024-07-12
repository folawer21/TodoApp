//
//  NewItemRowView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct NewItemRowView: View {
    @State var isCompleted = false
    var body: some View {
        Button(action: {},
               label: {
            Text("Новое")
                .foregroundStyle(Color.gray)
                .padding(.leading, 32)
        })
    }
}

#Preview {
    NewItemRowView()
}
