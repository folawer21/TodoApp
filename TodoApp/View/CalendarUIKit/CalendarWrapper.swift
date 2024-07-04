//
//  CalendarWrapper.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 05.07.2024.
//

import SwiftUI

struct CalendarWrapper: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = CalendarView()
        return view
    }
    
    
}

#Preview {
    CalendarWrapper()
}
