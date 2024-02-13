//
//  GaugeChart.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/18/24.
//

import UIKit
import SwiftUI


// MARK: - Today 화면에서 보여줄 total 게이지차트 정의
struct GaugeChart: View {
    @State private var progress = 0.3
    
    var body: some View {
        Gauge(value: progress) {
            Text("오늘의 목표 달성률")
                .foregroundColor(Color(.black))
                .font(Font.system(.body).weight(.bold))
        } currentValueLabel: {
            Text(progress.formatted(.percent))
        }
        .accentColor(Color(hex: 0x9FDEBD))
    }
}

