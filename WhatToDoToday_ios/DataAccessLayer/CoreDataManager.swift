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
    func getAllToDoData(forDate date: String = Date().toString()) -> [Todo] {
        let datePredicate = NSPredicate(format: "date == %@", date as CVarArg)
        var toDoList: [Todo] = []
        // 임시저장소 체크
        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.toDoEntityName)
            let dateOrder = NSSortDescriptor(key: "timeStamp", ascending: true)
            request.sortDescriptors = [dateOrder]
            request.predicate = datePredicate
            
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
    func saveToDoData(complete: Bool?, memoTitle: String?, date: String?, memoContent: String?, completion: @escaping () -> Void) {
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
                    toDoData.timeStamp = Date()
                    
                    appDelegate?.saveContext()
                }
            }
        }
        completion()
    }
    
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateToDo(newToDoData: Todo, completion: @escaping (String) -> Void) {
        // 날짜 옵셔널 바인딩
        guard let pkey = newToDoData.pkey else {
            completion("pkeyfindfail")
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.toDoEntityName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "pkey = %@", pkey as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기
                if let fetchedToDoList = try context.fetch(request) as? [Todo] {
                    // 배열의 첫번째
                    if var targetToDo = fetchedToDoList.first {
                        // MARK: - ToDoData에 실제 데이터 재할당(참조값을 바꿈)
                        targetToDo.date = newToDoData.date
                        targetToDo.memoTitle = newToDoData.memoTitle
                        targetToDo.memoContent = newToDoData.memoContent
                        appDelegate?.saveContext()
                    }
                }
                completion("success")
            } catch {
                print("[CoreDataManager] updateToDo Error")
                completion("fail")
            }
        }
    }
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
    func deleteToDo(data: Todo, completion: @escaping (String) -> Void) {
        guard let pkey = data.pkey else {
            completion("pkeyfindfail")
            return
        }
        
        // 임시저장소 있는지 확인
        if let context = context {
            // 요청서
            let request = NSFetchRequest<NSManagedObject>(entityName: self.toDoEntityName)
            // 단서 / 찾기 위한 조건 설정
            request.predicate = NSPredicate(format: "pkey = %@", pkey as CVarArg)
            
            do {
                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
                if let fetchedToDoList = try context.fetch(request) as? [Todo] {
                    
                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
                    if let targetToDo = fetchedToDoList.first {
                        context.delete(targetToDo)
                        appDelegate?.saveContext()
                    }
                }
                completion("success")
            } catch {
                print("coreData delete Error")
                completion("fail")
            }
        }
    }
}
