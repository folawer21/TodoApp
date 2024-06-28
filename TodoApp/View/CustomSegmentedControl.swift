//
//  CustomSegmentedControl.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var selectedImportance: Importance
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: { /*selectedImportance = .unimportant*/ }) {
                Image(systemName: "arrow.down")
                    .imageScale(.medium)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }
            .padding()
            .background(selectedImportance == .unimportant ? Color.white : Color.clear)
            .frame(width: 48.98, height: 31.5)
            .cornerRadius(8.91)
            .onTapGesture {
                selectedImportance = .unimportant
            }
        
            
            Divider().frame(height: 31.5)
            
            Button(action: { /*selectedImportance = .regular */}) {
                Text("Нет")
                    .font(.system(size: 15))
                    .foregroundColor(.black)
                    
            }
            .padding()
            .background(selectedImportance == .regular ? Color.white : Color.clear)
            .frame(width: 58.98, height: 31.5)
            .cornerRadius(8.91)
            .onTapGesture {
                selectedImportance = .regular
            }
           

            Divider().frame(height: 31.5)
            
            Button(action: { /*selectedImportance = .important */}) {
                Image(systemName: "exclamationmark.2")
                    .imageScale(.medium)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .cornerRadius(8.91)
            }
            .padding()
            .background(selectedImportance == .important ? Color.white : Color.clear)
            .frame(width: 48.98, height: 31.5)
            .cornerRadius(8.91)
            .onTapGesture {
                selectedImportance = .important
            }
            
        }
//        .padding()
        .background(Color.white.opacity(0.2))
        .frame(width: 150 , height: 36)
        .cornerRadius(8.91)
        .shadow(radius: 2)
    }
}
struct ContentView: View {
    @State private var selectedImportance: Importance = .regular
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Важность")
                        Spacer()
                        CustomSegmentedControl(selectedImportance: $selectedImportance)
                           
                    }
                    Divider()
                    HStack {
                        Text("Сделать до")
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}




#Preview {
    ContentView()
}
