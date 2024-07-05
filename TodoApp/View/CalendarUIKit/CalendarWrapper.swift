//
//  CalendarWrapper.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 05.07.2024.
//

import SwiftUI

struct CalendarWrapper: UIViewControllerRepresentable {
    @ObservedObject var taskManager: TaskManager
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let view = CalendarView()
        view.taskManager = self.taskManager
        return view
    }
    
    
}

#Preview {
    CalendarWrapper(taskManager: TaskManager())
}
