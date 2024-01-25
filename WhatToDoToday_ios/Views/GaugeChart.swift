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
            Text("50%")
                .foregroundColor(Color(.black))
        }
        .accentColor(Color(hex: 0x9FDEBD))
    }
}




