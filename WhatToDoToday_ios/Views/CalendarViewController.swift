//
//  CalendarViewController.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/18/24.
//

import UIKit
import SwiftUI


class CalendarViewController: UIViewController {
    
    var date: String = Date().toString()
    
    var toDoListData: [Todo] = []
    
    let calendarGaugeChartData = CalendarGaugeChartData(coreDataManager: CoreDataManager.shared)
    
    var dateSelection: UICalendarSelectionSingleDate!
    
    var decorations: [Date?: UICalendarView.Decoration] = [:]
    
    let toDoViewModel = TodoViewModel(coreDataManager: CoreDataManager.shared)

    
    // MARK: - 캘린더
    private lazy var calendar: UICalendarView = {
        var view = UICalendarView()
        view.calendar = .current
        view.locale = Locale(identifier: "ko_KR")
        view.fontDesign = . rounded
        view.wantsDateDecorations = true
        view.layer.borderWidth = 1
        view.layer.borderColor = #colorLiteral(red: 0.7764706016, green: 0.7764706016, blue: 0.7764706016, alpha: 1)
        view.layer.cornerRadius = 10
        view.tintColor = UIColor.lightGray
        return view
    }()

    
    // MARK: - 해야할일들을 표시하기 위한 테이블 뷰
    private lazy var ToDoList: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.white
        tv.layer.borderWidth = 1
        tv.layer.borderColor = #colorLiteral(red: 0.7764706016, green: 0.7764706016, blue: 0.7764706016, alpha: 1)
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    
    // MARK: - emptyView 설정
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.addSubview(emptyViewText)
        return view
    }()
    
    // MARK: - emptyView text 설정
    private var emptyViewText: UILabel = {
        let label = UILabel()
        label.text = "해당 날짜에는 할 일이 존재하지 않아요"
        label.textColor = #colorLiteral(red: 0.7921568627, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        // 데이터를 업데이트 할때 캘린더 새로고침
        calendar.setNeedsDisplay()
        ToDoList.reloadData()
        makeEmptyView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        makeConstraint()
        config()
        setTableView()
        setupNavigationBar()
        calendarConfig()
        toDoListData = toDoViewModel.getAllToDoData(forDate: Date().toString())
        print("viewDidLoad toDoListData: \(toDoListData)")
    }
    
    private func calendarConfig() {
        calendar.delegate = self
        // 날짜 선택을 위한 설정
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendar.selectionBehavior = dateSelection

    }
    
    private func config() {
        ToDoList.dataSource = self
        ToDoList.delegate = self
    }
    
    private func setTableView() {
        ToDoList.register(ToDoListCell.self, forCellReuseIdentifier: "ToDoListCell")
        ToDoList.separatorStyle = .singleLine
        ToDoList.separatorColor = .lightGray
        ToDoList.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    }
    
    
   
    
    
    private func setUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(calendar)
        view.addSubview(ToDoList)
        view.addSubview(emptyView)

        calendar.translatesAutoresizingMaskIntoConstraints = false
        ToDoList.translatesAutoresizingMaskIntoConstraints = false
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        emptyViewText.translatesAutoresizingMaskIntoConstraints = false
    }
    
    

    

    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            
            calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),

            calendar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            calendar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            ToDoList.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ToDoList.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 5),
            ToDoList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            ToDoList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            ToDoList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            
            
            
            emptyView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            emptyView.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 5),
            emptyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            emptyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            emptyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10),
            
            
            emptyViewText.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            emptyViewText.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor)

        ])
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
        
        title = "CALENDAR"
        
        // 네비게이션바 우측에 Plus 버튼 만들기
        let plusButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(todoPlusButtonTapped))
        plusButton.tintColor = .black
        navigationItem.rightBarButtonItem = plusButton
    }
    
    
    @objc private func todoPlusButtonTapped() {
        let addToDoVC = AddToDoViewController()
        addToDoVC.previous = "Calendar"
        addToDoVC.toDoDate = Date()
        addToDoVC.title = "할일 추가" // title 설정
        navigationController?.pushViewController(addToDoVC, animated: true)
    }
    
    // MARK: - 테이블뷰에 데이터가 없을때 보여줄 엠티뷰
    private func makeEmptyView() {
        let dataCount = toDoViewModel.getAllToDoData(forDate: Date().toString()).count
        // 데이터가 없을때 예외처리
        if dataCount == 0 {
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
        }
    }
    
    

    
}

// MARK: - 테이블뷰 설정
extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoViewModel.getAllToDoData(forDate: Date().toString()).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ToDoList.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
        
        let toDoDataArray = toDoViewModel.getAllToDoData(forDate: date)
        
        // 셀에 모델(ToDoData) 전달
//        let toDoData = toDoViewModel.getAllToDoData(forDate: Date().toString())
        
        print("toDoData: \(toDoListData)")
        print("toDoData indexpath: \(toDoListData[indexPath.row])")
        let toDoData = toDoListData[indexPath.row]
        //        cell.toDoData = toDoData[indexPath.row]
        cell.toDoData = toDoData
        if cell.toDoData?.complete == true {
            cell.toDoMark.backgroundColor = #colorLiteral(red: 0.5023792982, green: 0.807808578, blue: 0.8718705773, alpha: 1)
        } else {
            cell.toDoMark.backgroundColor = #colorLiteral(red: 0.7921568627, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        }
        
        
        cell.selectionStyle = .none
        return cell
        
        
    }
}


// MARK: - 테이블뷰 설정
extension CalendarViewController: UITableViewDelegate {
    // MARK: - 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    // MARK: - 셀 클릭 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 선택된 셀의 uuid를 가져옴
        let toDoData = toDoViewModel.getAllToDoData(forDate: Date().toString())
        if indexPath.row < toDoData.count {
            let selectedToDo = toDoData[indexPath.row]
            // 셀을 클릭했을 때 실행되는 코드
            let toDoDetailVC = ToDoDetailViewController()
            toDoDetailVC.selectedToDo = selectedToDo
            toDoDetailVC.modalPresentationStyle = .automatic
            present(toDoDetailVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - 테이블뷰 셀을 옆으로 드래그해서 삭제하는 기능
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let toDoData = toDoViewModel.getAllToDoData(forDate: Date().toString())
        if editingStyle == .delete {
            // 여기에 삭제하는 코드 작성
            if indexPath.row < toDoData.count {
                let selectedToDo = toDoData[indexPath.row]
                toDoViewModel.deleteToDo(
                    data: selectedToDo,
                    completion: { result in
                        switch result {
                        case "success":
                            print("Todo 삭제완료")
                            self.makeEmptyView()
                        case "fail":
                            print("Todo 삭제실패")
                        case "pkeyfindfail":
                            print("Todo pkey 찾기 실패")
                        default:
                            print("Todo delete 알수 없는 결과")
                        }
                    }
                )
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {}
        
    }
    
}




// MARK: - 캘린더에서 날짜를 선택하면 선택한 날짜에 해당하는 데이터를 불러옴
extension CalendarViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let selectedDateComponents = dateComponents {
            let calendar = Calendar.current
            if let selectedDate = calendar.date(from: selectedDateComponents) {
                print("Selected Date: \(selectedDate)")
                
                // 새로운 날짜에 해당하는 데이터를 가져옴
                let dateString = selectedDate.toString()
                date = dateString
                toDoListData = toDoViewModel.getAllToDoData(forDate: date)
                
                // 테이블 뷰 업데이트
                ToDoList.reloadData()
                makeEmptyView()
            }
        }
    }
}



// MARK: - 캘린더에 데이터가 있는 날짜는 표시
extension CalendarViewController: UICalendarViewDelegate {
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {

        let day = DateComponents(
                    calendar: dateComponents.calendar,
                    timeZone: dateComponents.timeZone,
                    year: dateComponents.year,
                    month: dateComponents.month,
                    day: dateComponents.day
                )
        guard let date = day.date else { return nil }
        
        //데이터예시) ["2024-02-10", "2024-02-24", "2024-02-27", "2024-02-15", "2024-02-29", "2024-02-08", "2024-02-09", "2024-02-19", "2024-02-20", "2024-02-28"]
        let data = toDoViewModel.getAllToDoDataForCalendar()
        
        if data.contains(date.toString()) {
            // 포함되어 있다면 데코레이션을 반환하거나 원하는 로직 수행
            return .default(color: #colorLiteral(red: 0.5023792982, green: 0.807808578, blue: 0.8718705773, alpha: 1) , size: .medium)
        }

        // 포함되어 있지 않다면 nil 반환 (데코레이션을 표시하지 않음)
        return nil

    }
}

// MARK: - preview를 위한...
#if DEBUG
struct CalendarViewControllerPreview: PreviewProvider {
    static var previews: some View {
        CalendarViewController()
            .toPreview()
    }
}
#endif
