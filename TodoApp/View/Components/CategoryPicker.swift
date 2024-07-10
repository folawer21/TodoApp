//
//  CategoryPicker.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 05.07.2024.
//

import SwiftUI

struct CategoryPicker: View {
    @Binding var selectedColor: Color
    let colors = [Color.red, Color.green, Color.blue, Color.clear]
    let colorNames = ["Работа", "Хобби", "Учеба", "Другое"]
    var body: some View {
        VStack {
            Picker(selection: $selectedColor, label: Text("Выберите цвет")) {
                ForEach(0..<colors.count) { index in
                    HStack {
                        Text(self.colorNames[index])
                            .font(.system(size: 16))
                            .frame(width: 80)
                        Circle()
                            .fill(self.colors[index])
                            .frame(width: 20, height: 20)
                    }.tag(colors[index])
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: 120, height: 45)
        }
    }
}

// #Preview {
//
//    CategoryPicker(selectedColor: .red)
// }
