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
    @IBOutlet weak var checkTermImage: UIImageView!
    @IBOutlet weak var termLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var backLoginLabel: UILabel!
    
    var presenter: RegisterPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Đăng kí tài khoản"
        self.setBackButtonWithImage("icn_back", withAction: #selector(backButtonAction))
    }

    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerButtonDidTouch(_ sender: UIButton) {
        self.register()
    }
}

// MARK: - Init View
extension RegisterViewController {
    override func initUI() {
        
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
            let email = self.emailTextField.text else { return }
        
        let params: [String: Any] = [
            kLoginName: loginName,
            kPassword: password,
            kFirstName: name,
            kPhoneNumber: phone,
            kEmail: email,
            
        ]
        
        self.presenter?.register(params: params)
    }
}

// MARK: - LoginPresenterView
extension RegisterViewController: RegisterPresenterView {
    func registerCompleted(isSuccess: Bool) {
        let message = isSuccess ? "Đã đăng kí tài khoản thành công" : "Có lỗi xảy ra"
        AppUtil.showAlert(message, callback: { [weak self] in
            self?.backButtonAction()
        })
    }
}
