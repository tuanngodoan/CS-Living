//
//  UIViewController.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit

func classDomain<T>(_ object: T.Type) -> String {
    return String(describing: object)
}

extension UIViewController {
    class func controller<T: UIViewController>(from storyboard: String, storyboardID: String? = nil) -> T {
           let storyboard = UIStoryboard(name: storyboard, bundle: nil)
           if let identifier = storyboardID {
               return storyboard.instantiateViewController(withIdentifier: identifier) as! T
           }
           return storyboard.instantiateViewController(withIdentifier:classDomain(T.self)) as! T
    }
}

extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
