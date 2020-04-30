//
//  NotificationViewController.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/29/20.
//

import UIKit

class NotificationViewController: UITableViewController {
    
    var listNotifi: [NotifiModel] = []
    var currentPageIndex = 0
    var presenter: NotificationPresenter?
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = NotificationPresenter.init(view: self)
        self.getNotification()
        self.navigationController?.navigationBar.isHidden = false;
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.title = "Danh sách thông báo"
        self.setBackButtonWithImage("icn_back", withAction: #selector(backButtonAction))
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Private func
extension NotificationViewController {
    func goToDetailNotification(notifi: NotifiModel) {
        if let detailVC = NotificationDetailViewController.controller(from: "Notification", storyboardID: "NotificationDetailViewController") as? NotificationDetailViewController {
            detailVC.notifi = notifi
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

// MARK: - Public func
extension NotificationViewController {
    
}

// MARK: - API CALL
extension NotificationViewController {
    func getNotification() {
        let currentUser = User.currentUser()
        guard let blockID = currentUser.blockID,
            let floorID = currentUser.floorID,
            let unitID = currentUser.unitID else {
                return
        }
        
        let param = [
              kPropertyID: 4,
              kBlockID: blockID,
              kFloorID: floorID,
              kUnitID: unitID
            ] as [String : Any]
        self.presenter?.getNotification(param: param)
    }
}

// MARK: - NotificationPresenterView
extension NotificationViewController: NotificationPresenterView {
    func getNotificationCompletion(listNotifi: [NotifiModel]) {
        self.listNotifi = listNotifi
        self.tableView.reloadData()
    }
}

//MARK: UITableView Delegate & DataSource
extension NotificationViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNotifi.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedMessage = listNotifi[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifiTableViewCell") as! NotifiTableViewCell
        
        cell.dateSendLabel.text =  displayedMessage.timeprocess?.showLocal()
        cell.mailImage.image = #imageLiteral(resourceName: "icon-about-email")
        if displayedMessage.isRead != nil && displayedMessage.isRead == 1 {
            cell.titleLabel.font = .systemFont(ofSize: 15)
            cell.messageTextView.font = .systemFont(ofSize: 15)
        } else {
            cell.titleLabel.font = .boldSystemFont(ofSize: 20)
            cell.messageTextView.font = .boldSystemFont(ofSize: 14)
        }
        cell.messageTextView.text = displayedMessage.content
        cell.titleLabel.text = displayedMessage.tilte
        cell.messageTextView.textContainer.maximumNumberOfLines = 4
        cell.messageTextView.textContainer.lineBreakMode =  .byTruncatingTail
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNotifi = self.listNotifi[indexPath.row]
        self.goToDetailNotification(notifi: selectedNotifi)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
