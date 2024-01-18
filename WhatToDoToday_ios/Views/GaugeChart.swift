//
//  GaugeChart.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/18/24.
//

import UIKit
import SwiftUI

struct GaugeChart: View {
    @State private var progress = 0.5
    
    var body: some View {
        Gauge(value: progress) {
            Text("")
                .background(Color.white)
                .foregroundColor(Color(.white))
        }
        .accentColor(Color(hex: 0x9FDEBD))
    }
}

extension Color {
    init(hex: UInt, alpha: Double = 1.0) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: alpha
        )
    }
    
    init(hex: Int, alpha: Double = 1.0) {
        self.init(hex: UInt(hex), alpha: alpha)
    }
    
    init(hex: String, alpha: Double = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        self.init(
            .sRGB,
            red: Double((rgb & 0xFF0000) >> 16) / 255.0,
            green: Double((rgb & 0x00FF00) >> 8) / 255.0,
            blue: Double(rgb & 0x0000FF) / 255.0,
            opacity: alpha
        )
    }
}
