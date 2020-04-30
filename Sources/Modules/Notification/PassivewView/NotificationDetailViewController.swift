//
//  NotificationDetailViewController.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/29/20.
//

import UIKit

class NotificationDetailViewController: BaseViewController {
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var fileTableView: UITableView!
    
    var notifi: NotifiModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupData()
        self.setupTableView()
        self.navigationController?.navigationBar.isHidden = false;
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = notifi?.tilte
        self.setBackButtonWithImage("icn_back", withAction: #selector(backButtonAction))
    }
    
    func setupData() {
        self.contentTextView.text = notifi?.content
        if let timeStr = notifi?.timeprocess {
            let date = timeStr.showLocal()
            self.timeLabel.text = "Ngày \(date)"
        }
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension NotificationDetailViewController {
    func setupTableView() {
        
        let fileCell = UINib(nibName: "FileNotifiCell", bundle: nil)
        self.fileTableView.register(fileCell, forCellReuseIdentifier: "FileNotifiCell")
        
        self.fileTableView.dataSource = self
        self.fileTableView.delegate = self
    }
}

extension NotificationDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FileNotifiCell", for: indexPath) as? FileNotifiCell {
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
    
}

extension NotificationDetailViewController: UITableViewDelegate {
    
}



