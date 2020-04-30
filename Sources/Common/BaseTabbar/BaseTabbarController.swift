//
//  BaseTabbarController.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit

class BaseTabbarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        let homeVC = HomeViewController.controller(from: "Home", storyboardID: "HomeViewController")
         homeVC.tabBarItem = UITabBarItem(title: "Trang chủ", image: UIImage(named: "ic_home"), selectedImage: nil)
        let navHome = BaseNavigationController(rootViewController: homeVC)
        // khuyến mãi
        let promotionVC = UIViewController.init()
        promotionVC.tabBarItem = UITabBarItem(title: "Khuyến mãi", image: UIImage(named: "icon_promotion"), selectedImage: nil)
      
        // calendar
        let calendarVC = UIViewController()
        calendarVC.tabBarItem = UITabBarItem(title: "Dịch vụ", image: UIImage(named: "icn_calendar"), selectedImage: nil)
        
        // Tài khoản
        let userVC = UIViewController()
        userVC.tabBarItem = UITabBarItem(title: "Tài khoản", image: UIImage(named: "iconAccount"), selectedImage: nil)
        
        let navUser = BaseNavigationController(rootViewController: userVC)
        
        let navCalendar = BaseNavigationController(rootViewController: calendarVC)
        
        let navPromotion = BaseNavigationController.init(rootViewController: promotionVC)
       
        self.viewControllers = [navHome, navPromotion, navCalendar, navUser]
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}
