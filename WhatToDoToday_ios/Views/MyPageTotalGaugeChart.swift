import UIKit
import SwiftUI


// MARK: - MyPage 화면에서 보여줄 total 게이지차트 정의
struct MyPageTotalGaugeChart: View {
    @State private var progress = 0.3
    
    var body: some View {
        Gauge(value: progress) {
            Text("전체")
                .foregroundColor(Color(.black))
                .font(Font.system(.body).weight(.bold))
        } currentValueLabel: {
            Text(progress.formatted(.percent))
        }
        .accentColor(Color(hex: 0x9FDEBD))
    }
}
