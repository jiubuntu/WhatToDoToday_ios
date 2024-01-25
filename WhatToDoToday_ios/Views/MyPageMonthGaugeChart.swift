import UIKit
import SwiftUI


// MARK: - MyPage 화면에서 보여줄 month 게이지차트 정의
struct MyPageMonthGaugeChart: View {
    @State private var progress = 0.5
    
    var body: some View {
        Gauge(value: progress) {
            Text("최근 30일")
                .foregroundColor(Color(.black))
                .font(Font.system(.body).weight(.bold))
        } currentValueLabel: {
            Text(progress.formatted(.percent))
        }
        .accentColor(Color(hex: 0x9FDEBD))
    }
}
