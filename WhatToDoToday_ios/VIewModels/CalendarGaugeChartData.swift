import UIKit

class CalendarGaugeChartData: ObservableObject {
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    @Published var progress: Double = 0.0 // 초기값 설정
    
    
    // MARK: - Today 화면에서 gaugechart에 표시할 데이터 처리
    func TodayUpdateProgress() {
        let data = coreDataManager.getAllToDoData()
        let totalCount = data.count
        let completedCount = data.filter { $0.complete }.count
        
        if totalCount != 0 {
            // 소수점 두번째 자리까지 표시
            progress = ((Double(completedCount)/Double(totalCount)) * 100).rounded() / 100
        } else {
            progress = 0
        }
        print("progress: \(progress)")
    }
}


