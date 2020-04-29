//
//  NotificationDetailViewController.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/29/20.
//

import UIKit

class NotificationDetailViewController: BaseViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var notifi: NotifiModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
    }
    
    func setupData() {
        self.titleLabel.text = notifi?.tilte
        self.contentTextView.text = notifi?.content
        self.timeLabel.text = notifi?.timeprocess
    }
    
  
}
