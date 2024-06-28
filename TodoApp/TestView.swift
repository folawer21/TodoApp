//
//  TestView.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//


//import SwiftUI
//import Foundation
//
//struct CustomSegmentedControl: View {
//    
//    @Binding var selectedImportance: Importance
//    var body: some View {
//        HStack {
//            Button(action: { selectedImportance = .unimportant }) {
//                Image(systemName: "arrow.down")
//                    .padding()
//                    .imageScale(.large)
//                    .foregroundColor(.gray)
//                    .background(selectedImportance == .unimportant ? Color.gray.opacity(0.2) : Color.clear)
//                    .cornerRadius(8.91)
//            }
//            Divider().frame(height: 31.5)
//            Button(action: { selectedImportance = .regular }) {
//                Text("Нет")
//                .padding()
//                .foregroundColor(.black)
//                .background(selectedImportance == .regular ? Color.gray.opacity(0.2) : Color.clear)
//                .cornerRadius(8.91)
//            }
//            Divider().frame(height: 31.5)
//            Button(action: { selectedImportance = .important }) {
//                Image(systemName: "exclamationmark.2")
//                    .foregroundColor( .red )
//                    .padding()
//                    .fontWeight(.bold)
//                    .imageScale(.large)
//                    .background(selectedImportance == .important ? Color.gray.opacity(0.2) : Color.clear)
//                    .cornerRadius(8.91)
//            }
//            
//        }
//        .frame(height: 31.5)
//        .padding()
//        .background(Color.white.opacity(0.06))
//        .cornerRadius(8.91)
//        .shadow(radius: 2)
//    }
//}
//
//struct ContentView: View {
//    @State private var selection: Importance = Importance.regular
//    
//    var body: some View {
//
//        CustomSegmentedControl(selectedImportance: $selection)
//        .padding()
//    }
//}
//#Preview {
//    ContentView()
//}

import SwiftUI


//struct CustomSegmentedControl: View {
//    @Binding var selectedImportance: Importance
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            Button(action: { selectedImportance = .unimportant }) {
//                Image(systemName: "arrow.down")
//                    .padding()
//                    .imageScale(.large)
//                    .foregroundColor(selectedImportance == .unimportant ? .gray : .black)
//                    .background(selectedImportance == .unimportant ? Color.gray.opacity(0.2) : Color.clear)
//                    .cornerRadius(8.91)
//            }
//            .frame(maxWidth: .infinity)
//            .border(Color.red)
//            
//            Divider().frame(height: 31.5)
//            
//            Button(action: { selectedImportance = .regular }) {
//                Text("Нет")
//                    .padding()
//                    .foregroundColor(selectedImportance == .regular ? .black : .black)
//                    .background(selectedImportance == .regular ? Color.gray.opacity(0.2) : Color.clear)
//                    .cornerRadius(8.91)
//                    .font(.system(size: 15))
//            }
//            .frame(maxWidth: .infinity)
//            .border(Color.red)
//            
//            Divider().frame(height: 31.5)
//            
//            Button(action: { selectedImportance = .important }) {
//                Image(systemName: "exclamationmark.2")
//                    .foregroundColor(.red )
//                    .padding()
//                    .imageScale(.large)
//                    .background(selectedImportance == .important ? Color.gray.opacity(0.2) : Color.clear)
//                    .cornerRadius(8.91)
//            }
//            .border(Color.red)
//            .frame(maxWidth: .infinity)
//        }
//        
//        .frame(height: 31.5)
//        .padding()
//        .background(Color.white.opacity(0.06))
//        .cornerRadius(8.91)
//        .shadow(radius: 2)
//    }
//}
//
//struct ContentView: View {
//    @State private var selectedImportance: Importance = .regular
//    
//    var body: some View {
//        Section {
//            VStack(alignment: .leading) {
//                HStack {
//                    Text("Важность")
//                    Spacer()
//                    CustomSegmentedControl(selectedImportance: $selectedImportance)
//                        .frame(width: 200)
//                }
//                Divider()
//                HStack {
//                    Text("Сделать до")
//                    Spacer()
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//struct CustomSegmentedControl: View {
//    @Binding var selectedImportance: Importance
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            Label {
//                Image(systemName: "arrow.down")
//                    .padding()
//                    .imageScale(.large)
//            } icon: {
//                Text("")
//                    .foregroundColor(selectedImportance == .unimportant ? .gray : .black)
//                    .background(selectedImportance == .unimportant ? Color.gray.opacity(0.2) : Color.clear)
//                    .cornerRadius(8.91)
//            }
//            .frame(maxWidth: .infinity)
//            .border(Color.red)
//            .onTapGesture {
//                selectedImportance = .unimportant
//            }
//            
//            Divider().frame(height: 31.5)
//            
//            Label {
//                Text("Нет")
//                    .padding()
//                    .font(.system(size: 15))
//            } icon: {
//                Text("")
//                    .foregroundColor(selectedImportance == .regular ? .black : .black)
//                    .background(selectedImportance == .regular ? Color.gray.opacity(0.2) : Color.clear)
//                    .cornerRadius(8.91)
//            }
//            .frame(maxWidth: .infinity)
//            .border(Color.red)
//            .onTapGesture {
//                selectedImportance = .regular
//            }
//            
//            Divider().frame(height: 31.5)
//            
//            Label {
//                Image(systemName: "exclamationmark.2")
//                    .padding()
//                    .imageScale(.large)
//                    .foregroundColor(.red)
//            } icon: {
//                Text("")
//                    .background(selectedImportance == .important ? Color.gray.opacity(0.2) : Color.clear)
//                    .cornerRadius(8.91)
//            }
//            .frame(maxWidth: .infinity)
//            .border(Color.red)
//            .onTapGesture {
//                selectedImportance = .important
//            }
//        }
//        .frame(height: 31.5)
//        .padding()
//        .background(Color.white.opacity(0.06))
//        .cornerRadius(8.91)
//        .shadow(radius: 2)
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSegmentedControl(selectedImportance: Binding<Importance>.constant(.important) )
//    }
//}

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
        .frame(width: 150 /*, height: 36*/)
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


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomSegmentedControl(selectedImportance: Binding<Importance>.constant(.important))
    }
}
