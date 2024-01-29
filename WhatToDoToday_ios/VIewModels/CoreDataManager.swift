import UIKit
import CoreData




// MARK: - 코어데이터와 상호작용 하는 모델 정의
final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시 저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔터티 정의
    let toDoEntityName: String = "Todo"
    
    
    // MARK: - Todo 데이터 모두 가져오기
    func getAllToDoData() -> [Todo] {
        var toDoList: [Todo] = []
        // 임시저장소 체크
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.toDoEntityName)
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                // 임시저장소에서 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [Todo] {
                    toDoList = fetchedToDoList
                }
            } catch {
                print("[CoreDataManager] getAllToDoData Error")
            }
                
        }
        return toDoList
    }
    
    
    
    // MARK: - Todo 데이터 생성하기
    func saveToDoData(complete: Bool?, memoTitle: String?, date: Date, memoContent: String?, completion: @escaping () -> Void) {
        // 임시저장소 있는지 확인
        if let context = context {
            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
            if let entity = NSEntityDescription.entity(forEntityName: self.toDoEntityName, in: context) {
                
                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? Todo {
                    
                    // MARK: - ToDo에 실제 데이터 할당
                    toDoData.pkey = UUID()
                    toDoData.complete = complete ?? false
                    toDoData.date = date
                    toDoData.memoTitle = memoTitle
                    toDoData.memoContent = memoContent
                    
                    appDelegate?.saveContext()
                }
            }
        }
        completion()
    }
}
