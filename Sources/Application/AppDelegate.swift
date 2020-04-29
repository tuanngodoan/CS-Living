//
//  AppDelegate.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        setupRootLoginViewController()
        return true
    }
    
    func setupRootLoginViewController() {
          let loginVC = LoginViewController.controller(from: "Login", storyboardID: "LoginViewController")
          let navi = UINavigationController(rootViewController: loginVC)
          self.window = UIWindow(frame: UIScreen.main.bounds)
          self.window?.rootViewController = navi
          self.window?.makeKeyAndVisible()
      }

    func showHome(){
        let tabbarController = BaseTabbarController()
        AppUtil.visibleViewController?.present(tabbarController, animated: true, completion: {
            let window = UIApplication.shared.windows.first
            window?.rootViewController = tabbarController
            //window?.makeKeyAndVisible()
        })
    }

}

