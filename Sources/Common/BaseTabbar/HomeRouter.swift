//
//  HomeRouter.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit

class HomeRouter: Router {
    func execute(in context: UIViewController) {
        let controller: HomeViewController = HomeViewController.controller(from: "Home")
    }
}
