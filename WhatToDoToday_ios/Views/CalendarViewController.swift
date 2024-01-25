//
//  CalendarViewController.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/18/24.
//

import UIKit
import SwiftUI


class CalendarViewController: UIViewController {
    
    // MARK: - 캘린더를 보여줄 뷰
    private lazy var CalendarView: UIView = {
        let view = UIView()
        view.addSubview(Calendar)
        return view
    }()
    
    // MARK: - 캘린더
    private lazy var Calendar: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ko_KR")
        return datePicker
    }()
    
    // MARK: - 목표 달성률 보여주는 뷰
    private lazy var CalendarGoalAchievementRateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        view.layer.borderWidth = 1
        view.addSubview(CalendarGoalLabel)
        view.addSubview(CalendarRateView)
        return view
    }()
    
    // MARK: - 목표 달성률 라벨
    private var CalendarGoalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = UIColor.black
        label.text = "목표 달성률"
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - 목표 달성률 차트영역
    private var CalendarRateView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.white
        return view
    }()
    
    
    // MARK: - 해야할일들을 표시하기 위한 테이블 뷰
    private lazy var CalendarToDoList: UITableView = {
        let tv = UITableView()
        // 다크모드인지 체크
        if traitCollection.userInterfaceStyle == .light {
            tv.backgroundColor = UIColor.white
        } else {
            tv.backgroundColor = UIColor.black
        }
        return tv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        makeConstraint()
        setLightDarkMode()
        config()
        setTableView()
        setGaugeChart()
        setupNavigationBar()
    }
    
    private func config() {
        CalendarToDoList.dataSource = self
        CalendarToDoList.delegate = self
    }
    
    private func setTableView() {
        CalendarToDoList.register(ToDoListCell.self, forCellReuseIdentifier: "ToDoListCell")
        CalendarToDoList.separatorStyle = .none
    }
    
    
    // MARK: - 다크모드일때와 라이트모드일때 다르게 세팅
    private func setLightDarkMode() {
        if #available(iOS 16.0, *) {
            if self.traitCollection.userInterfaceStyle == .light {
                view.backgroundColor = UIColor.white
                Calendar.layer.borderWidth = 1
                Calendar.layer.cornerRadius = 10
                Calendar.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
                Calendar.backgroundColor = UIColor.white
                Calendar.tintColor = UIColor.systemYellow
                Calendar.setValue(UIColor.black, forKey: "textColor")
                if let datePickerText = Calendar.subviews.first?.subviews.last as? UITextField {
                    datePickerText.textColor = UIColor.black
                }
            } else {
                view.backgroundColor = UIColor.black
                Calendar.backgroundColor = UIColor.black
                Calendar.tintColor = UIColor.systemYellow
                Calendar.setValue(UIColor.white, forKey: "textColor")
                
                if let datePickerText = Calendar.subviews.first?.subviews.last as? UITextField {
                    datePickerText.textColor = UIColor.white
                }
            }
        } else {
            Calendar.setValue(UIColor.black, forKey: "textColor")
        }
    }
    
    
    private func setUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(CalendarGoalAchievementRateView)
        view.addSubview(CalendarView)
        view.addSubview(CalendarToDoList)
        
        CalendarGoalAchievementRateView.translatesAutoresizingMaskIntoConstraints = false
        CalendarGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        CalendarRateView.translatesAutoresizingMaskIntoConstraints = false
        Calendar.translatesAutoresizingMaskIntoConstraints = false
        CalendarView.translatesAutoresizingMaskIntoConstraints = false
        CalendarToDoList.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    // MARK: - 게이지차트 설정
    private func setGaugeChart() {
        let hostingController = UIHostingController(rootView: CalendarGaugeChart())
        hostingController.view.backgroundColor = UIColor.white
        // ViewController에 hostingController를 Child로 추가
        addChild(hostingController)
        CalendarRateView.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: CalendarRateView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: CalendarRateView.leadingAnchor, constant: 20),
            hostingController.view.trailingAnchor.constraint(equalTo: CalendarRateView.trailingAnchor, constant: -20),
            hostingController.view.bottomAnchor.constraint(equalTo: CalendarRateView.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            CalendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            CalendarView.heightAnchor.constraint(equalToConstant: 300),
            CalendarView.widthAnchor.constraint(equalToConstant: 350),
            CalendarView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            Calendar.topAnchor.constraint(equalTo: CalendarView.topAnchor, constant: 0),
            Calendar.leadingAnchor.constraint(equalTo: CalendarView.leadingAnchor, constant: 0),
            Calendar.trailingAnchor.constraint(equalTo: CalendarView.trailingAnchor, constant: 0),
            Calendar.bottomAnchor.constraint(equalTo: CalendarView.bottomAnchor, constant: 0),
            
            CalendarGoalAchievementRateView.topAnchor.constraint(equalTo: CalendarView.bottomAnchor, constant: 8),
            CalendarGoalAchievementRateView.heightAnchor.constraint(equalToConstant: 100),
            CalendarGoalAchievementRateView.widthAnchor.constraint(equalToConstant: 350),
            CalendarGoalAchievementRateView.centerXAnchor.constraint(equalTo: CalendarView.centerXAnchor),
            
            
            CalendarGoalLabel.centerXAnchor.constraint(equalTo: CalendarGoalAchievementRateView.centerXAnchor),
            CalendarGoalLabel.widthAnchor.constraint(equalTo: CalendarGoalAchievementRateView.widthAnchor, constant: -200),
            CalendarGoalLabel.heightAnchor.constraint(equalToConstant: 20),
            CalendarGoalLabel.topAnchor.constraint(equalTo: CalendarGoalAchievementRateView.topAnchor, constant: 10),
            
            
//            CalendarRateView.heightAnchor.constraint(equalToConstant: 90),
            CalendarRateView.topAnchor.constraint(equalTo: CalendarGoalLabel.bottomAnchor, constant: 10),
            CalendarRateView.centerXAnchor.constraint(equalTo: CalendarGoalLabel.centerXAnchor),
            CalendarRateView.widthAnchor.constraint(equalTo: CalendarGoalAchievementRateView.widthAnchor, constant: 0),
            
            
            CalendarToDoList.widthAnchor.constraint(equalToConstant: 350),
            CalendarToDoList.heightAnchor.constraint(equalToConstant: 250),
            CalendarToDoList.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            CalendarToDoList.topAnchor.constraint(equalTo: CalendarGoalAchievementRateView.bottomAnchor, constant: 10),
            
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
        addToDoVC.toDoDate = Date()
        addToDoVC.title = "할일 추가" // title 설정
        navigationController?.pushViewController(addToDoVC, animated: true)
    }
    
}

// MARK: - 테이블뷰 설정
extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
        if traitCollection.userInterfaceStyle == .light {
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = UIColor.white
            cell.backgroundColor = UIColor.white
            cell.toDoTitle.textColor = UIColor.black
            cell.toDoTitle.text = "test"
            return cell
        } else {
            cell.selectionStyle = .none
            cell.contentView.backgroundColor = UIColor.black
            cell.backgroundColor = UIColor.black
            cell.toDoTitle.textColor = UIColor.white
            cell.toDoTitle.text = "test"
            return cell
        }
    }
}


// MARK: - 테이블뷰 설정
extension CalendarViewController: UITableViewDelegate {
    // MARK: - 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    // MARK: - 셀 클릭 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 셀을 클릭했을 때 실행되는 코드
        let toDoDetailVC = ToDoDetailViewController()
        toDoDetailVC.modalPresentationStyle = .automatic
        present(toDoDetailVC, animated: true, completion: nil)
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
