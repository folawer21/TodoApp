//
//  CompleteButton.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 27.06.2024.
//

import SwiftUI

struct CompleteButton: View {
   @Binding var isCompleted: Bool
   var importance: Importance
   
    var body: some View {
       Circle()
           .fill(backgroundColor)
           .stroke(borderColor, lineWidth: 1.5)
           .frame(width: 24,height: 24)
           .overlay(){
               Image(systemName: "checkmark")
                   .fontWeight(.bold)
                   .imageScale(.small)
                   .foregroundColor(foregroundColor)
           }
                   
             
    }
    
    var backgroundColor: Color  {
        return isCompleted ? Color.green : (importance == .important ? .red.opacity(0.1) : Color.clear)
    }
    
    var foregroundColor: Color{
        isCompleted ? .white : .clear
    }
    
    var borderColor: Color{
        if importance == .important && isCompleted == false{
            return .red
        }
        else if importance == .important && isCompleted == true{
            return .green
        }else{
            return .gray.opacity(0.4)
        }
    }
}

