
import UIKit

final class ToDoListCell: UITableViewCell {
    
    let toDoViewModel = TodoViewModel(coreDataManager: CoreDataManager.shared)
    
    // MARK: - 데이터 저장
    var toDoData: Todo? {
        didSet {
            configureUIwithData()
        }
    }
    
    
    // MARK: - 할 일의 상태표시를 보여주는 뷰
    lazy var toDoMark = {
        let view = UIView()
        view.layer.cornerRadius = 8.5
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toDoMarkTap))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = #colorLiteral(red: 0.5023792982, green: 0.807808578, blue: 0.8718705773, alpha: 1)
        return view
    }()
    
    // MARK: - 할 일 내용
    let toDoTitle = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.black
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupLayout()
        setConstrains()
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // todoMark를 원모양으로 만드는 코드
        //        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
        
        contentView.layer.masksToBounds = true
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        contentView.addSubview(toDoMark)
        contentView.addSubview(toDoTitle)
        
        
    }
    
    func setConstrains() {
        setToDoMark()
        setToDoTitle()
    }
    
    func setToDoMark() {
        toDoMark.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDoMark.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            toDoMark.widthAnchor.constraint(equalToConstant: 17),
            toDoMark.heightAnchor.constraint(equalToConstant: 17),
            toDoMark.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        ])
    }
    
    func setToDoTitle() {
        toDoTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toDoTitle.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            toDoTitle.centerYAnchor.constraint(equalTo: toDoMark.centerYAnchor),
            toDoTitle.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // 데이터를 가지고 표시하기
    func configureUIwithData() {
        toDoTitle.text = toDoData?.memoTitle
    }
    
    
    // MARK: - 진동을 발생시키는 함수
    func vibrate() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
    
    
    // MARK: - toDoMark를 눌렀을때 동작하는 함수
    @objc func toDoMarkTap() {
        guard let toDoData = toDoData else { return }
        
        // 진동
        vibrate()
        
        // toDoMark의 색이 하늘색일때 -> 회색(false)
        if toDoData.complete == true {
            toDoData.complete = false
            toDoViewModel.updateToDo(
                newToDoData: toDoData,
                completion: { result in
                    switch result {
                    case "success":
                        print("Todo 업데이트 완료")
                        self.toDoMark.backgroundColor = #colorLiteral(red: 0.7921568627, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
                    case "fail":
                        print("Todo 업데이트 실패")
                    case "pkeyfindfail":
                        print("Todo Pkey 찾기 실패")
                    default:
                        print("ToDo Update 알수없는 결과")
                        
                    }
                }
            )
        } else { // toDoMark의 색이 회색일때 -> 하늘색(true)
            toDoData.complete = true
            toDoViewModel.updateToDo(
                newToDoData: toDoData,
                completion: { result in
                    switch result {
                    case "success":
                        print("Todo 업데이트 완료")
                        self.toDoMark.backgroundColor = #colorLiteral(red: 0.5023792982, green: 0.807808578, blue: 0.8718705773, alpha: 1)
                    case "fail":
                        print("Todo 업데이트 실패")
                    case "pkeyfindfail":
                        print("Todo Pkey 찾기 실패")
                    default:
                        print("ToDo Update 알수없는 결과")
                        
                    }
                }
            )
            toDoMark.backgroundColor = #colorLiteral(red: 0.5023792982, green: 0.807808578, blue: 0.8718705773, alpha: 1)
        }
    }
}
