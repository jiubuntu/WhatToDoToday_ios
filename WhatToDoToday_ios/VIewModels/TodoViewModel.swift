import UIKit



// MARK: - coreDataManager를 통하여 data access
final class TodoViewModel {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func getAllToDoData() -> [Todo] {
        return coreDataManager.getAllToDoData()
    }
        
    func saveToDoData(complete: Bool?, memoTitle: String?, date: Date, memoContent: String?, completion: @escaping () -> Void) {
        
    }
}
