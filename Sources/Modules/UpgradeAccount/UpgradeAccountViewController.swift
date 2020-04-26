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
        self.setBackButtonWithImage("icn_back", withAction: #selector(backButtonAction))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func upgradeAccountDidTouch(_ sender: UIButton) {
        
    }

    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
