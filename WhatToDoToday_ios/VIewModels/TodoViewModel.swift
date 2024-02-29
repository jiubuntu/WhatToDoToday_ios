import UIKit



// MARK: - coreDataManager를 통하여 data access
final class TodoViewModel {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func getAllToDoData(forDate date: String = "") -> [Todo] {
        return coreDataManager.getAllToDoData(forDate: date)
    }
    
    
    // MARK: - toDo데이터가 존재하는 날짜만 추출해서 배열로 return
    func getAllToDoDataForCalendar(forDate date: String = Date().toString()) -> [String] {
        let data = coreDataManager.getAllToDoData(forDate: "")
        // 중복을 제거한 날짜들을 저장할 Set
        var uniqueDates = Set<String>()

        // 중복을 제거한 날짜들을 담을 배열
        var uniqueDatesArray: [String] = []

        // 배열 안의 각 딕셔너리에서 "date" 키의 값을 가져와서 Set에 추가
        for row in data {
            if let date = row.date {
                uniqueDates.insert(date)
            }
        }
        // Set을 배열로 변환
        uniqueDatesArray = Array(uniqueDates)

        // 중복이 제거된 날짜들 출력
        return uniqueDatesArray
    }
        
    
    func saveToDoData(complete: Bool?, memoTitle: String?, date: String?, memoContent: String?, completion: @escaping () -> Void) {
        coreDataManager.saveToDoData(complete: complete, memoTitle: memoTitle, date: date, memoContent: memoContent, completion: completion)
    }
    
    func updateToDo(newToDoData: Todo, completion: @escaping (String) -> Void) {
        self.coreDataManager.updateToDo(newToDoData: newToDoData, completion: completion)
    }
    
    func deleteToDo(data: Todo, completion: @escaping (String) -> Void) {
        self.coreDataManager.deleteToDo(data: data, completion: completion)
    }
    
    
}
