//
//  FeeListViewController.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/27/20.
//

import UIKit

class FeeListViewController: BaseViewController {

    private var presenter: FeePresenter?
    
    @IBOutlet weak var pickDateView: UIStackView!
    @IBOutlet weak var formDateTextField: UITextField!
    @IBOutlet weak var toDateTextField: UITextField!
    @IBOutlet weak var pickServiceView: UIView!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var totalBillView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    private let datePicker = UIDatePicker()
    private var pickerService: PickerBlurView?
    private var currentDatePicker: UITextField?
    
    private var heightHeaderTableView: CGFloat = 50.0
    private var heightCell: CGFloat = 38.0
    
    private var feeList: FeeModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Bảng kê phí"
        self.setBackButtonWithImage("icn_back", withAction: #selector(backButtonAction))
        
        let tapPickerService = UITapGestureRecognizer(target: self, action: #selector(showPickerService))
        self.pickServiceView?.addGestureRecognizer(tapPickerService)
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
    
    @IBAction func watchButtonDidTouch(_sender: UIButton) {
        let param = [
              kFromDate: "2020-04-29T11:37:12.737Z",
              kToDate: "2020-04-29T11:37:12.737Z",
              kContractId: 514,
              kUnit: "B2-505"
            ] as [String : Any]
        self.presenter?.getListService(param: param)
    }
}


// MARK: - Init View
extension FeeListViewController {
    override func initUI() {
        super.initUI()
        self.setupTableViewUI()
        self.showDatePicker(textField: self.formDateTextField)
        self.showDatePicker(textField: self.toDateTextField)
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
        self.presenter = FeePresenter.init(view: self)
    }
}

// MARK: - Private func
extension FeeListViewController {
    func showDatePicker(textField: UITextField) {
        textField.delegate = self
        //Formate Date
        datePicker.datePickerMode = .date
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Chọn", style: .plain, target: self, action: #selector(donedatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Hủy", style: .plain, target: self, action: #selector(cancelDatePicker))

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    @objc func showPickerService() {
        if pickerService == nil {
            guard let pickerView = PickerBlurView.fromNib() as? PickerBlurView else {
                return
            }
            pickerService = pickerView
        }
        let dummyService = ["Chọn dịch vụ", "NUOC", "DIEN", "BVMT", "XE", "PQL",  "KHAC"]
        pickerService?.configData(dummyService)
        pickerService?.selectedRow = 0
        pickerService?.delegate = self
        pickerService?.showPickerView()
    }

     @objc func donedatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        currentDatePicker?.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }

    @objc func cancelDatePicker() {
        self.view.endEditing(true)
     }
}

// MARK: - Public func
extension FeeListViewController {
    
}

// MARK: - API CALL
extension FeeListViewController {
    
}

// MARK: - FeePresenterView
extension FeeListViewController: FeePresenterView {
    func getListServiceCompletion(feeList: FeeModel) {
        self.feeList = feeList
        self.tableView.reloadData()
    }
}

// MARK: - TableViewDatasoure
extension FeeListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeList?.dataDetail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FeeTableViewCell", for: indexPath) as? FeeTableViewCell {
            cell.setupCell(feeDetail: feeList?.dataDetail?[indexPath.row])
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
        if let footerView = FeeTableFooterView.fromNib() as? FeeTableFooterView,
            let fee = self.feeList {
            footerView.loanPrevLabel.text = "\(fee.accruedExpense ?? 0)"
            footerView.endingDebtLabel.text = "\(fee.balnaceVND ?? 0)"
            footerView.incurredDebtLabel.text = "\(fee.openingDebit ?? 0)"
            footerView.paidLabel.text = "\(fee.paidAmount ?? 0)"
            return footerView
        }
        return UIView()
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

// MARK: - UITableViewDelegate
extension FeeListViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.currentDatePicker = textField
    }
}


// MARK: - Picker Blur View
extension FeeListViewController: PickerBlurViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, value: String?) {
        self.serviceLabel.text = value
    }
}
