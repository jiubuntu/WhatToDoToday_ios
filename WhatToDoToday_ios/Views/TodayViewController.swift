
import UIKit
import SwiftUI

class TodayViewController: UIViewController{
    
    let toDoViewModel = TodoViewModel(coreDataManager: CoreDataManager.shared)
    
    // MARK: - 오늘의 목표 달성률 보여주는 뷰
    private lazy var goalAchievementRateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        view.layer.borderWidth = 1
        view.addSubview(goalLabel)
        view.addSubview(RateView)
        return view
    }()
    
    
    // MARK: - 오늘의 목표 달성률 라벨
    private var goalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17.0)
        label.textColor = UIColor.black
        label.text = "오늘의 목표 달성률"
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - 오늘의 목표 달성률 차트영역
    private var RateView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    
    // MARK: - TODO를 추가하기 위한 버튼
    private lazy var ToDoTextFieldButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 27)
        button.contentVerticalAlignment = .center
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0
        button.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.8509803922, blue: 0.8392156863, alpha: 1)
        return button
    }()
    
    
    
    
    // MARK: - 해야할일들을 표시하기 위한 테이블 뷰
    private lazy var ToDoList: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        return tv
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        ToDoList.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        makeConstraint()
        config()
        setGaugeChart()
        setupNavigationBar()
    }
    
    private func config() {
        ToDoList.dataSource = self
        ToDoList.delegate = self
    }
    
    private func setTableView() {
        ToDoList.register(ToDoListCell.self, forCellReuseIdentifier: "ToDoListCell")
        ToDoList.separatorStyle = .none
    }
    
    private func setUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(goalAchievementRateView)
        view.addSubview(ToDoList)
        goalAchievementRateView.translatesAutoresizingMaskIntoConstraints = false
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        RateView.translatesAutoresizingMaskIntoConstraints = false
        ToDoList.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // 앱의 화면을 터치하면 키보드 밑으로 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            goalAchievementRateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            goalAchievementRateView.heightAnchor.constraint(equalToConstant: 130),
            goalAchievementRateView.widthAnchor.constraint(equalToConstant: 350),
            goalAchievementRateView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            
            goalLabel.centerXAnchor.constraint(equalTo: goalAchievementRateView.centerXAnchor),
            goalLabel.widthAnchor.constraint(equalTo: goalAchievementRateView.widthAnchor, constant: -200),
            goalLabel.heightAnchor.constraint(equalToConstant: 20),
            goalLabel.topAnchor.constraint(equalTo: goalAchievementRateView.topAnchor, constant: 10),
            
            RateView.heightAnchor.constraint(equalToConstant: 90),
            RateView.topAnchor.constraint(equalTo: goalLabel.bottomAnchor, constant: 10),
            RateView.centerXAnchor.constraint(equalTo: goalLabel.centerXAnchor),
            RateView.widthAnchor.constraint(equalTo: goalAchievementRateView.widthAnchor, constant: 0),
            
            
            ToDoList.widthAnchor.constraint(equalToConstant: 350),
            ToDoList.heightAnchor.constraint(equalToConstant: 500),
            ToDoList.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ToDoList.topAnchor.constraint(equalTo: goalAchievementRateView.bottomAnchor, constant: 10)
            
            
            
        ])
    }
    
    private func setGaugeChart() {
        let hostingController = UIHostingController(rootView: GaugeChart())
        hostingController.view.backgroundColor = UIColor.white
        // ViewController에 hostingController를 Child로 추가
        addChild(hostingController)
        RateView.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: RateView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: RateView.leadingAnchor, constant: 20),
            hostingController.view.trailingAnchor.constraint(equalTo: RateView.trailingAnchor, constant: -20),
            hostingController.view.bottomAnchor.constraint(equalTo: RateView.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    private func setupNavigationBar() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.9568627451, blue: 0.9058823529, alpha: 1)
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.scrollEdgeAppearance = navigationBarAppearance
        navigationItem.standardAppearance = navigationBarAppearance
        navigationItem.compactAppearance = navigationBarAppearance
        
        navigationController?.setNeedsStatusBarAppearanceUpdate()
        navigationController?.navigationBar.isTranslucent = false
        title = "TODAY"
        
        
        // 네비게이션바 우측에 Plus 버튼 만들기
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(todoPlusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }
    
    
    @objc private func todoPlusButtonTapped() {
        let addToDoVC = AddToDoViewController()
        addToDoVC.toDoDate = Date()
        addToDoVC.title = "할일 추가" // title 설정
        navigationController?.pushViewController(addToDoVC, animated: true)
    }
}


// MARK: - 테이블뷰 설정
extension TodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoViewModel.getAllToDoData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
        //        cell.selectionStyle = .none
        //        cell.contentView.backgroundColor = UIColor.white
        //        cell.backgroundColor = UIColor.white
        //        cell.toDoTitle.text = "test"
        //        return cell
        
        let cell = ToDoList.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
        // 셀에 모델(ToDoData) 전달
        let toDoData = toDoViewModel.getAllToDoData()
        cell.toDoData = toDoData[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}



extension TodayViewController: UITableViewDelegate {
    // MARK: - 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
    // MARK: - 셀 클릭 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 셀의 uuid를 가져옴
        let toDoData = toDoViewModel.getAllToDoData()
        print("toDoData \(toDoData)")
        if indexPath.row < toDoData.count {
            let selectedToDo = toDoData[indexPath.row]
            print("toDoData \(toDoData)")
            // 셀을 클릭했을 때 실행되는 코드
            let toDoDetailVC = ToDoDetailViewController()
            toDoDetailVC.selectedToDo = selectedToDo
            toDoDetailVC.modalPresentationStyle = .automatic
            present(toDoDetailVC, animated: true, completion: nil)
        }
        
    }
}


// MARK: - 텍스트필드 기능구현
extension TodayViewController: UITextFieldDelegate {
    // 엔터 누르면 키보드 내림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}



// MARK: - preview를 위한...
#if DEBUG
struct ViewControllerPreview: PreviewProvider {
    static var previews: some View {
        TodayViewController()
            .toPreview()
    }
}
#endif
