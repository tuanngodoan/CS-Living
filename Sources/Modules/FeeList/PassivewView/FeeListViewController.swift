//
//  FeeListViewController.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/27/20.
//

import UIKit

class FeeListViewController: BaseViewController {

    @IBOutlet weak var pickDateView: UIStackView!
    @IBOutlet weak var formDateLabel: UILabel!
    @IBOutlet weak var toDateLabel: UILabel!
    @IBOutlet weak var pickServiceView: UIView!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var totalBillView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private var heightHeaderTableView: CGFloat = 50.0
    private var heightCell: CGFloat = 38.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bảng kê phí"
        self.setBackButtonWithImage("icn_back", withAction: #selector(backButtonAction))
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            self.pickDateView.isHidden = true
            self.pickServiceView.isHidden = true
        } else {
            self.pickDateView.isHidden = false
            self.pickServiceView.isHidden = false
        }
    }
}


// MARK: - Init View
extension FeeListViewController {
    override func initUI() {
        super.initUI()
        self.setupTableViewUI()
    }
    
    func setupTableViewUI() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        let feeCell = UINib(nibName: "FeeTableViewCell", bundle: nil)
        self.tableView.register(feeCell, forCellReuseIdentifier: "FeeTableViewCell")
    }
}

// MARK: - Init Data
extension FeeListViewController {
    override func initData() {
        
    }
}

// MARK: - ConfigPresenter
extension FeeListViewController {
    override func configPresenter() {
        //self.presenter = HomePresenter.init(view: self)
    }
}

// MARK: - Private func
extension FeeListViewController {
    
}

// MARK: - Public func
extension FeeListViewController {
    
}

// MARK: - API CALL
extension FeeListViewController {
    
}

// MARK: - LoginPresenterView
//extension FeeListViewController: HomePresenterView {
//}

// MARK: - TableViewDatasoure
extension FeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeeTableViewCell", for: indexPath) as? FeeTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return FeeTableHeaderView.fromNib()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return heightHeaderTableView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return Bundle.main.loadNibNamed("FeeTableFooterView", owner: nil, options: nil)!.first as! FeeTableFooterView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return heightHeaderTableView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightCell
    }
}

// MARK: - UITableViewDelegate
extension FeeListViewController: UITableViewDelegate {
    
}
