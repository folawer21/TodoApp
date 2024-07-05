//
//  ColorExtension.swift
//  TodoApp
//
//  Created by Александр  Сухинин on 28.06.2024.
//



import SwiftUI

extension Color {
    func hexString() -> String {
        guard let components = UIColor(self).cgColor.components else {
            return "FFFFFF"
        }
        
        let red = components[0]
        let green = components[1]
        let blue = components[2]
        
        let hexString = String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
        
        return hexString
    }
}
