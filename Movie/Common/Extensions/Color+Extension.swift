//
//  Color+Extension.swift
//  Movie
//
//  Created by David Diego Gomez on 04/09/2024.
//

import SwiftUI

extension Color {
    init?(hex: String, alpha: Double? = nil) {
        var formattedHex = hex
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        
        guard let hexValue = UInt(formattedHex, radix: 16) else {
            return nil
        }
        
        let red = Double((hexValue & 0xFF0000) >> 16) / 255.0
        let green = Double((hexValue & 0x00FF00) >> 8) / 255.0
        let blue = Double(hexValue & 0x0000FF) / 255.0
        
        if let alpha = alpha {
            self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
        } else {
            self.init(.sRGB, red: red, green: green, blue: blue)
        }
    }
}


extension Color {
    enum Movie {
        static var titleColor: Color { return Color(hex: "#ECECEC") ?? .white}
        static var titleColorSecondary: Color { return Color(hex: "#EBEBEF") ?? .white}
        static var white: Color { return Color(hex: "#FFFFFF") ?? .white }
        static var paleWhite: Color { return Color(hex: "#EEEEEE") ?? .white }
        static var lightGray: Color { return Color(hex: "#92929D") ?? .gray }
        static var gray: Color { return Color(hex: "#67686D") ?? .gray }
        static var orange: Color { return Color(hex: "#FF8700") ?? .orange }
        static var primary: Color { return Color(hex: "#242A32") ?? .gray}
        static var secondary: Color { return Color(hex: "#3A3F47") ?? .gray}
        static var tintColor: Color { return Color(hex: "#0296E5") ?? .blue}
    }
}
