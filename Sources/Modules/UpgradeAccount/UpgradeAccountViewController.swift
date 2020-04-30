//
//  UpgradeAccountViewController.swift
//  CS-Living
//
//  Created by doanntuann on 4/25/20.
//

import UIKit

class UpgradeAccountViewController: BaseViewController {

    @IBOutlet weak var upgradeAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nâng cấp tài khoản"
       self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func upgradeAccountDidTouch(_ sender: UIButton) {
        let upgradeVC = InputUpgradeAccountViewController.controller(from: "Home", storyboardID: "InputUpgradeAccountViewController")
        self.navigationController?.pushViewController(upgradeVC, animated: true)
    }
    
    @IBAction func backButtonDidTouch(_ sender: UIButton) {
         self.navigationController?.popViewController(animated: true)
    }
}
