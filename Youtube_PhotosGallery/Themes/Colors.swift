//
//  Colors.swift
//  Youtube_PhotosGallery
//
//  Created by Sopheamen VAN on 16/7/24.
//

import SwiftUI

extension Color {
    // Hex color initializer
    init(hex: String, opacity: Double = 1.0) {
        let hexSanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = Double((rgb & 0xFF0000) >> 16) / 255.0
        let green = Double((rgb & 0x00FF00) >> 8) / 255.0
        let blue = Double(rgb & 0x0000FF) / 255.0

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }

    // Instagram Brand Colors
       static let primaryColor = Color(hex: "#019CFF") // Deep Blue
       static let gradientPurple = Color(hex: "#833AB4")
       static let gradientPink = Color(hex: "#FD1D1D")
       static let gradientOrange = Color(hex: "#F56040")
       static let gradientYellow = Color(hex: "#FCAF45")
    
    // Opacity
    static let blackOpacity = Color.black.opacity(0.6)
    
    // Textfield
    static let textFieldBackgroundColor = Color(hex: "#EFEFEF")

}
