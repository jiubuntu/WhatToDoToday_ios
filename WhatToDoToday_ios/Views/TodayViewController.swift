//
//  ViewController.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/17/24.
//

import UIKit
import SwiftUI

class TodayViewController: UIViewController {
    
    
    // MARK: - 오늘의 목표 달성률 보여주는 뷰
    private lazy var goalAchievementRateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray // UI 미리보기용
        view.layer.cornerRadius = 10
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
        label.backgroundColor = UIColor.blue
        return label
    }()
    
    
    // MARK: - 오늘의 목표 달성률 차트영역
    private var RateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 10
        return view
    }()
    
    // MARK: - TODO를 추가하기 위한 영역
    private lazy var ToDoTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.addSubview(ToDoTextField)
        view.addSubview(ToDoTextFieldButton)
        return view
    }()
    
    
    // MARK: - TODO를 추가하기 위한 텍스트필드
    private lazy var ToDoTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "해야 할 일을 입력해 주세요"
        return textField
    }()

    
    // MARK: - TODO를 추가하기 위한 버튼
    private lazy var ToDoTextFieldButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeUI()
        makeConstraint()
    }

    private func makeUI() {
        view.addSubview(goalAchievementRateView)
        goalAchievementRateView.translatesAutoresizingMaskIntoConstraints = false
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        RateView.translatesAutoresizingMaskIntoConstraints = false
        
        ToDoTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        ToDoTextField.translatesAutoresizingMaskIntoConstraints = false
        ToDoTextFieldButton.translatesAutoresizingMaskIntoConstraints = false
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
            ToDoTextFieldView.topAnchor.constraint(equalTo: goalAchievementRateView.bottomAnchor, constant: 10)
        ])
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
