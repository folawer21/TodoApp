//
//  CustomColorPickerView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//

import SwiftUI

struct CustomColorPickerView: View{
//    @State var colorHex: String? = nil
    @Binding  var selectedColor: Color
    @Binding  var brightness: Double

    let colors: [Color] = [.red, .green, .blue, .yellow, .orange, .purple, .pink, .cyan, .brown, .indigo, .mint , .gray]
    
    var body: some View{
        VStack(alignment: .leading){
            Spacer()
            HStack{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(selectedColor)
                    .brightness(1 - brightness)
                    .frame(width: 45,height: 45)
                Text("\(selectedColor.hexString())")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                
                Slider(value: $brightness, in: 0.0...1.0, step: 0.1)
                
            }
            .padding()
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 4)) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 50, height: 50)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            .padding()

        }
    }
}

//
//#Preview {
//    CustomColorPickerView()
//}
