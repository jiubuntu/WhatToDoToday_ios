//
//  ViewController.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/17/24.
//

import UIKit
import SwiftUI

class TodayViewController: UIViewController{

    // MARK: - 오늘의 목표 달성률 보여주는 뷰
    private lazy var goalAchievementRateView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.gray // UI 미리보기용
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
        label.text = "오늘의 목표 달성률"
        label.textAlignment = .center
//        label.backgroundColor = UIColor.blue
        return label
    }()
    
    
    // MARK: - 오늘의 목표 달성률 차트영역
    private var RateView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: - TODO를 추가하기 위한 영역
    private lazy var ToDoTextFieldView: UIView = {
        let view = UIView()
//        view.backgroundColor = UIColor.lightGray
        view.addSubview(ToDoTextField)
        view.addSubview(ToDoTextFieldButton)
        return view
    }()
    
    
    // MARK: - TODO를 추가하기 위한 텍스트필드
    private lazy var ToDoTextField: UITextField = {
        // 버튼을 생성하고 설정
        let textField = UITextField()
        textField.placeholder = "해야 할 일을 입력해 주세요"
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = #colorLiteral(red: 0.7882352941, green: 0.7882352941, blue: 0.7882352941, alpha: 1)
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        textField.rightView = ToDoTextFieldButton
        textField.rightViewMode = .always
        return textField
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
//        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - 해야할일들을 표시하기 위한 테이블 뷰
    private lazy var ToDoList: UITableView = {
        let tv = UITableView()
//        tv.backgroundColor = UIColor.lightGray
        return tv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setTableView()
        makeConstraint()
        
    }
    
    private func setTableView() {
        ToDoList.dataSource = self
        ToDoList.delegate = self
        // 셀의 높이 설정
//        ToDoList.rowHeight = 120
        ToDoList.register(ToDoListCell.self, forCellReuseIdentifier: "ToDoListCell")
    }

    private func setUI() {
        view.addSubview(goalAchievementRateView)
        goalAchievementRateView.translatesAutoresizingMaskIntoConstraints = false
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        RateView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(ToDoTextFieldView)
        ToDoTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        ToDoTextField.translatesAutoresizingMaskIntoConstraints = false
        ToDoTextFieldButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(ToDoList)
        ToDoList.translatesAutoresizingMaskIntoConstraints = false
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
            
            ToDoTextFieldView.heightAnchor.constraint(equalToConstant: 60),
            ToDoTextFieldView.widthAnchor.constraint(equalToConstant: 350),
            ToDoTextFieldView.topAnchor.constraint(equalTo: goalAchievementRateView.bottomAnchor, constant: 10),
            ToDoTextFieldView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            
            ToDoTextField.centerYAnchor.constraint(equalTo: ToDoTextFieldView.centerYAnchor),
            ToDoTextField.leadingAnchor.constraint(equalTo: ToDoTextFieldView.leadingAnchor, constant: 0),
            ToDoTextField.widthAnchor.constraint(equalTo: ToDoTextFieldView.widthAnchor, constant: -0),
            ToDoTextField.heightAnchor.constraint(equalToConstant: 30),

            
            ToDoTextFieldButton.widthAnchor.constraint(equalToConstant: 50),
            ToDoTextFieldButton.heightAnchor.constraint(equalToConstant: 30),
            
            ToDoList.widthAnchor.constraint(equalToConstant: 350),
            ToDoList.heightAnchor.constraint(equalToConstant: 420),
            ToDoList.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ToDoList.topAnchor.constraint(equalTo: ToDoTextFieldView.bottomAnchor, constant: 10)
            

            
        ])
    }
}

extension TodayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as! ToDoListCell
        cell.selectionStyle = .none
        cell.toDoTitle.text = "test"
        return cell
    }
}



extension TodayViewController: UITableViewDelegate {
    // MARK: - 셀의 높이 설정
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
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
