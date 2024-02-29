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
    @ObservedObject var gaugeChartData: GaugeChartData // ObservableObject를 사용하여 데이터 바인딩
    
    var body: some View {
        Gauge(value: gaugeChartData.progress) {
            Text("오늘의 목표 달성률")
                .foregroundColor(Color(.black))
                .font(Font.system(.body).weight(.bold))
        } currentValueLabel: {
            Text(gaugeChartData.progress.formatted(.percent))
        }
        .accentColor(Color(hex: 0x9FDEBD))
    }
}

