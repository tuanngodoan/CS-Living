//
//  RegisterViewController.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/25/20.
//

import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var pickerAvatarView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPassTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var unitTextField: UITextField!
    @IBOutlet weak var checkTermImage: UIImageView!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    private var projectList: [LicenseModel] = []
    private var projectPicked: LicenseModel?
    private var unitPicked: UnitModel?
    private var pickingProject = false
    
    private var isCheckedTerm: Bool = true
    private var pickerBlurView: PickerBlurView?
    
    var presenter: RegisterPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Đăng kí tài khoản"
        self.setBackButtonWithImage("icn_back", withAction: #selector(backButtonAction))
        self.navigationController?.navigationBar.isHidden = false
        self.tapHandler()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func registerButtonDidTouch(_ sender: UIButton) {
        self.register()
    }
    
    @IBAction func backToLoginDidTouch(_ sender: UIButton) {
        self.backButtonAction()
    }
}

// MARK: - Init View
extension RegisterViewController {
    override func initUI() {
        super.initUI()
        termLabelUI()
    }
    
    func termLabelUI() {
        let range = (termLabel.text! as NSString).range(of: "Điều khoản")
        let attribute = NSMutableAttributedString.init(string: termLabel.text!)
        attribute.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue,
                                 NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue],
                                range: range)
        termLabel.attributedText = attribute
    }
    
    
}

// MARK: - Init Data
extension RegisterViewController {
    override func initData() {

    }
}

// MARK: - ConfigPresenter
extension RegisterViewController {
    override func configPresenter() {
        self.presenter = RegisterPresenter.init(view: self)
    }
}

// MARK: - Private func
extension RegisterViewController {
    func tapHandler() {
        let tapTerm = UITapGestureRecognizer(target: self, action: #selector(toggleCheckTerm))
        checkTermImage.addGestureRecognizer(tapTerm)
        
        let tapProject = UITapGestureRecognizer(target: self, action: #selector(getProjectPicker))
        projectTextField.addGestureRecognizer(tapProject)
        
        let tapUnit = UITapGestureRecognizer(target: self, action: #selector(showUnitPicker))
        unitTextField.addGestureRecognizer(tapUnit)
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func toggleCheckTerm() {
        self.isCheckedTerm = !self.isCheckedTerm
        self.checkTermImage.image = self.isCheckedTerm ? UIImage(named: "icn_check") : UIImage(named: "icn_uncheck")
    }
    
    @objc func getProjectPicker() {
        self.presenter.getListLicense()
    }
    
    func showProjectPicker() {
        if pickerBlurView == nil {
            guard let pickerView = PickerBlurView.fromNib() as? PickerBlurView else {
                return
            }
            pickerBlurView = pickerView
        }
        self.pickingProject = true
        
        let listTitle = projectList.map { (license) -> String in
            return (license.name ?? "")
        }
        
        pickerBlurView?.configData(listTitle)
        pickerBlurView?.showPickerView(isShowCancelButton: false)
        pickerBlurView?.delegate = self
    }
    
    @objc func showUnitPicker() {
        if pickerBlurView == nil || self.projectPicked == nil {
            return
        }
        
        self.pickingProject = false
        
        let listUnitName = self.projectPicked?.unit?.map { (unit) -> String in
            return (unit.name ?? "")
        }
        
        pickerBlurView?.configData(listUnitName ?? [])
        pickerBlurView?.showPickerView(isShowCancelButton: false)
    }
}

// MARK: - Public func
extension RegisterViewController {
    
}

// MARK: - API CALL
extension RegisterViewController {
    func register() {
        guard let loginName = self.userNameTextField.text,
            let password = self.passwordTextField.text,
            let name = self.fullNameTextField.text,
            let phone = self.phoneTextField.text,
            let email = self.emailTextField.text,
            let ownerCode = self.projectPicked?.ownerCode,
            let unitName = self.unitTextField.text else { return }
        
        let params: [String: Any] = [
            kLoginName: loginName,
            kPassword: password,
            kFirstName: name,
            kPhoneNumber: phone,
            kEmail: email,
            kUnitName: unitName,
            kOwnerCode: ownerCode,
            kConfigLinkCode: ownerCode
        ]
        
        self.presenter?.register(params: params)
    }
}

// MARK: - LoginPresenterView
extension RegisterViewController: RegisterPresenterView {
    func getLicenseCompleted(listLicense: [LicenseModel]) {
        self.projectList = listLicense
        self.showProjectPicker()
    }
    
    func registerCompleted(isSuccess: Bool) {
        let message = isSuccess ? "Đã đăng kí tài khoản thành công" : "Có lỗi xảy ra"
        AppUtil.showAlert(message, callback: { [weak self] in
            self?.backButtonAction()
        })
    }
}


// MARK: - LoginPresenterView
extension RegisterViewController: PickerBlurViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, value: String?) {
        if value == nil {
            return
        }
        
        if self.pickingProject {
            self.projectPicked = self.projectList[row]
            self.projectTextField.text = self.projectPicked?.name
            self.unitTextField.text = ""
        } else {
            self.unitPicked = self.projectPicked?.unit?[row]
            self.unitTextField.text = self.unitPicked?.name
        }
    }
}
