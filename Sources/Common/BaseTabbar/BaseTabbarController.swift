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
        let navHome = BaseNavigationController(rootViewController: homeVC)
        navHome.tabBarItem = UITabBarItem(title: "Trang chủ", image: UIImage(named: "fb_events"), selectedImage: nil)
        self.viewControllers = [navHome, navHome, navHome, navHome]
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
}
