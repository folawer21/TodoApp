//
//  PlusButton.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct PlusButton: View {
    var body: some View {
        Button(action: {
        },
               label: {
            Image(systemName: "plus")
                .fontWeight(.bold)
                .imageScale(.large)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(Color.blue.shadow(.drop(color: .black.opacity(0.25), radius: 7, x: 0, y: 10)), in: .circle)
        })
    }
}

#Preview {
    PlusButton()
}
