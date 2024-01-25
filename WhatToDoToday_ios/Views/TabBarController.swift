//
//  TabBarControllerViewController.swift
//  WhatToDoToday_ios
//
//  Created by 김지우 on 1/18/24.
//

import UIKit
import SwiftUI

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = #colorLiteral(red: 0.7921568627, green: 0.7843137255, blue: 0.7843137255, alpha: 1)
        tabBar.tintColor = UIColor.white
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.5331481099, green: 0.5331481099, blue: 0.5331481099, alpha: 1)
        
        // MARK: - 모든 탭 바 아이템에 대해 폰트 크기 설정
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.5)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        
        let firstVC = UINavigationController(rootViewController: TodayViewController())
        firstVC.tabBarItem.title = "TODAY" // TabBar Item 의 이름
        
        let secondVC = UINavigationController(rootViewController: CalendarViewController())
        secondVC.tabBarItem.title = "CALENDAR"
        
        let thirdVC = UINavigationController(rootViewController: MyPageViewController())
        thirdVC.tabBarItem.title = "MY"
        
        viewControllers = [
            firstVC,
            secondVC,
            thirdVC,
        ]
    }
    
}

// MARK: - preview를 위한...
#if DEBUG
struct TabBarControllerPreview: PreviewProvider {
    static var previews: some View {
        TabBarController()
            .toPreview()
    }
}
#endif
