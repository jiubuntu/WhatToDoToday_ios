import UIKit
import SwiftUI


// MARK: - 캘린더 화면에서 보여줄 게이지차트 정의
struct CalendarGaugeChart: View {
    @State private var progress = 0.5
    
    var body: some View {
        Gauge(value: progress) {
            Text("50%")
                .foregroundColor(Color(.black))
        }
        .accentColor(Color(hex: 0x9FDEBD))
    }
    func hello() {}
}
