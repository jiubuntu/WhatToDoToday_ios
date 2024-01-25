//
//  MyPageViewController.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/18/24.
//

import UIKit
import SwiftUI


class MyPageViewController: UIViewController {

    // MARK: - 목표 달성률 보여주는 뷰
    private lazy var MyPageGoalAchievementRateView: UIView = {
        let view = UIView()
        view.addSubview(MyPageGoalLabel)
        view.addSubview(MyPageRateView)
        return view
    }()
    
    // MARK: - 목표 달성률 라벨
    private var MyPageGoalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 21.0)
        label.textColor = UIColor.black
        label.text = "목표 달성률"
        label.textAlignment = .center
        return label
    }()
    
    
    // MARK: - 목표 달성률 차트영역
    private lazy var MyPageRateView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        view.layer.borderWidth = 1
        view.addSubview(totalRateView)
        view.addSubview(monthRateView)
        view.addSubview(weekRateView)
        return view
    }()
    
    private var totalRateView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var monthRateView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var weekRateView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var settingView: UIView = {
        let view = UIView()
        view.addSubview(settingLabel)
        view.addSubview(settingFunctionsView)
        return view
    }()
    
    private var settingLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    
    private lazy var settingFunctionsView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = #colorLiteral(red: 0.7764705882, green: 0.7764705882, blue: 0.7764705882, alpha: 1)
        view.layer.borderWidth = 1
        view.addSubview(darkModeView)
        view.addSubview(inquireView)
        return view
    }()
    
    private lazy var darkModeView: UIView = {
        let view = UIView()
        view.addSubview(darkModeLabel)
        view.addSubview(darkModeToggle)
        return view
    }()
    
    private var darkModeLabel: UILabel = {
        let label = UILabel()
        label.text = "다크모드"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    // MARK: - 다크모드 토글
    private var darkModeToggle: UISwitch = {
        let toggle = UISwitch()
        return toggle
    }()
    
    // MARK: - 문의하기
    private lazy var inquireView: UIView = {
        let view = UIView()
        view.addSubview(inquireLabel)
        return view
    }()
    
    private var inquireLabel: UILabel = {
        let label = UILabel()
        label.text = "문의하기"
        label.font = UIFont.boldSystemFont(ofSize: 21)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setLightDarkMode()
        setUI()
        makeConstraint()
        setTotalGaugeChart()
        setMonthGaugeChart()
        setWeekGaugeChart()
        setToggleColor()
    }
    
    private func setToggleColor() {
        darkModeToggle.onTintColor = #colorLiteral(red: 0.5596321225, green: 0.8747346401, blue: 0.8704335093, alpha: 1)
    }
    
    private func config() {
    }
    
    private func setUI() {
        view.addSubview(MyPageGoalAchievementRateView)
        view.addSubview(settingView)
        
        MyPageGoalAchievementRateView.translatesAutoresizingMaskIntoConstraints = false
        MyPageGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        MyPageRateView.translatesAutoresizingMaskIntoConstraints = false
        totalRateView.translatesAutoresizingMaskIntoConstraints = false
        monthRateView.translatesAutoresizingMaskIntoConstraints = false
        weekRateView.translatesAutoresizingMaskIntoConstraints = false
        settingView.translatesAutoresizingMaskIntoConstraints = false
        settingLabel.translatesAutoresizingMaskIntoConstraints = false
        settingFunctionsView.translatesAutoresizingMaskIntoConstraints = false
        darkModeView.translatesAutoresizingMaskIntoConstraints = false
        darkModeLabel.translatesAutoresizingMaskIntoConstraints = false
        darkModeToggle.translatesAutoresizingMaskIntoConstraints = false
        inquireView.translatesAutoresizingMaskIntoConstraints = false
        inquireLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: - total 게이지차트 설정
    private func setTotalGaugeChart() {
        let hostingController = UIHostingController(rootView: MyPageTotalGaugeChart())
        hostingController.view.backgroundColor = UIColor.white
        // ViewController에 hostingController를 Child로 추가
        addChild(hostingController)
        totalRateView.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: totalRateView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: totalRateView.leadingAnchor, constant: 20),
            hostingController.view.trailingAnchor.constraint(equalTo: totalRateView.trailingAnchor, constant: -20),
            hostingController.view.bottomAnchor.constraint(equalTo: totalRateView.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    // MARK: - month 게이지차트 설정
    private func setMonthGaugeChart() {
        let hostingController = UIHostingController(rootView: MyPageMonthGaugeChart())
        hostingController.view.backgroundColor = UIColor.white
        // ViewController에 hostingController를 Child로 추가
        addChild(hostingController)
        monthRateView.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: monthRateView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: monthRateView.leadingAnchor, constant: 20),
            hostingController.view.trailingAnchor.constraint(equalTo: monthRateView.trailingAnchor, constant: -20),
            hostingController.view.bottomAnchor.constraint(equalTo: monthRateView.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    // MARK: - week 게이지차트 설정
    private func setWeekGaugeChart() {
        let hostingController = UIHostingController(rootView: MyPageWeekGaugeChart())
        hostingController.view.backgroundColor = UIColor.white
        // ViewController에 hostingController를 Child로 추가
        addChild(hostingController)
        weekRateView.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: weekRateView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: weekRateView.leadingAnchor, constant: 20),
            hostingController.view.trailingAnchor.constraint(equalTo: weekRateView.trailingAnchor, constant: -20),
            hostingController.view.bottomAnchor.constraint(equalTo: weekRateView.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            MyPageGoalAchievementRateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            MyPageGoalAchievementRateView.widthAnchor.constraint(equalToConstant: 350),
            MyPageGoalAchievementRateView.heightAnchor.constraint(equalToConstant: 220),
            MyPageGoalAchievementRateView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            MyPageGoalLabel.centerXAnchor.constraint(equalTo: MyPageGoalAchievementRateView.centerXAnchor),
            
            MyPageRateView.topAnchor.constraint(equalTo: MyPageGoalLabel.bottomAnchor, constant: 10),
            MyPageRateView.centerXAnchor.constraint(equalTo: MyPageGoalAchievementRateView.centerXAnchor),
            MyPageRateView.widthAnchor.constraint(equalToConstant: 350),
            MyPageRateView.heightAnchor.constraint(equalToConstant: 200),
            
            totalRateView.widthAnchor.constraint(equalToConstant: 350),
            totalRateView.heightAnchor.constraint(equalToConstant: 100),
            totalRateView.centerXAnchor.constraint(equalTo: MyPageRateView.centerXAnchor),
            
            monthRateView.widthAnchor.constraint(equalToConstant: 175),
            monthRateView.heightAnchor.constraint(equalToConstant: 100),
            monthRateView.leadingAnchor.constraint(equalTo: MyPageRateView.leadingAnchor, constant: 0),
            monthRateView.bottomAnchor.constraint(equalTo: MyPageRateView.bottomAnchor, constant: 0),
            
            weekRateView.widthAnchor.constraint(equalToConstant: 175),
            weekRateView.heightAnchor.constraint(equalToConstant: 100),
            weekRateView.trailingAnchor.constraint(equalTo: MyPageRateView.trailingAnchor, constant: 0),
            weekRateView.bottomAnchor.constraint(equalTo: MyPageRateView.bottomAnchor, constant: 0),
            
            settingView.topAnchor.constraint(equalTo: MyPageGoalAchievementRateView.bottomAnchor, constant: 50),
            settingView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            settingView.widthAnchor.constraint(equalToConstant: 350),
            settingView.heightAnchor.constraint(equalToConstant: 150),
            
            settingLabel.centerXAnchor.constraint(equalTo: settingView.centerXAnchor),
            
            settingFunctionsView.widthAnchor.constraint(equalToConstant: 350),
            settingFunctionsView.heightAnchor.constraint(equalToConstant: 110),
            settingFunctionsView.bottomAnchor.constraint(equalTo: settingView.bottomAnchor, constant: 0),
            
            darkModeView.widthAnchor.constraint(equalToConstant: 350),
            darkModeView.heightAnchor.constraint(equalToConstant: 55),
            darkModeView.centerXAnchor.constraint(equalTo: settingFunctionsView.centerXAnchor),
            darkModeView.topAnchor.constraint(equalTo: settingFunctionsView.topAnchor, constant: 0),
            
            darkModeLabel.leadingAnchor.constraint(equalTo: darkModeView.leadingAnchor, constant: 20),
            darkModeLabel.centerYAnchor.constraint(equalTo: darkModeView.centerYAnchor),

            darkModeToggle.centerYAnchor.constraint(equalTo: darkModeView.centerYAnchor),
            darkModeToggle.trailingAnchor.constraint(equalTo: darkModeView.trailingAnchor, constant: -20),
            
            inquireView.widthAnchor.constraint(equalToConstant: 350),
            inquireView.heightAnchor.constraint(equalToConstant: 55),
            inquireView.centerXAnchor.constraint(equalTo: settingFunctionsView.centerXAnchor),
            inquireView.topAnchor.constraint(equalTo: darkModeView.bottomAnchor, constant: 0),
            
            inquireLabel.leadingAnchor.constraint(equalTo: inquireView.leadingAnchor, constant: 20),
            inquireLabel.centerYAnchor.constraint(equalTo: inquireView.centerYAnchor),
        ])
    }
    
    // MARK: - 다크모드일때와 라이트모드일때 다르게 세팅
    private func setLightDarkMode() {
        if #available(iOS 16.0, *) {
            if self.traitCollection.userInterfaceStyle == .light {
                view.backgroundColor = .white
            } else {
                view.backgroundColor = .black
            }
        }
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
        
        title = "MY"
    }

}

// MARK: - preview를 위한...
#if DEBUG
struct MyPageViewControllerPreview: PreviewProvider {
    static var previews: some View {
        MyPageViewController()
            .toPreview()
    }
}
#endif
