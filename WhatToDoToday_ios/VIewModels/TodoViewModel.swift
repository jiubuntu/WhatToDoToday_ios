import UIKit



// MARK: - coreDataManager를 통하여 data access
final class TodoViewModel {
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func getAllToDoData(forDate date: String = Date().toString()) -> [Todo] {
        return coreDataManager.getAllToDoData(forDate: date)
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
