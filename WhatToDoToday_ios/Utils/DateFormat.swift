import UIKit

struct DateFormat {
    
    // MARK: - Date를 String으로 변환
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: date)
    }
    
    // MARK: - String을 Date으로 변환
    func StringToDate(dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if let date = formatter.date(from: dateString) {
            return date
        } else {
            print("String -> Date 변환 실패")
            return nil
        }
    }
}
