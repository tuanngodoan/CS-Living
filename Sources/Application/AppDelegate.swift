//
//  AppDelegate.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit
import Firebase
import Bagel
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        Bagel.start()
        appearance()
        if let accessToken = UserDefaults.standard.value(forKey: kAccessToken) as? String, accessToken.count > 0 {
            setupRootHomeVC()
        } else {
            setupRootLoginViewController()
        }
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
            window?.makeKeyAndVisible()
        })
    }
    
    func setupRootHomeVC() {
        let tabbarController = BaseTabbarController()
        let window = UIApplication.shared.windows.first
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()
    }
}

private extension AppDelegate {
    func appearance() {
        /* Navigation Bar */
//        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        UINavigationBar.appearance().shadowImage = UIImage()
        window?.backgroundColor = UIColor.white
    }
    
}
