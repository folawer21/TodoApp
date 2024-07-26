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
    init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int: UInt64 = 0
            Scanner(string: hex).scanHexInt64(&int)
            let alpha, red, green, blue: UInt64
            switch hex.count {
            case 3:
                (alpha, red, green, blue) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6:
                (alpha, red, green, blue) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: 
                (alpha, red, green, blue) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (alpha, red, green, blue) = (1, 1, 1, 0)
            }
            self.init(
                .sRGB,
                red: Double(red) / 255,
                green: Double(green) / 255,
                blue:  Double(blue) / 255,
                opacity: Double(alpha) / 255
            )
        }
}
