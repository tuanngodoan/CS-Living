//
//  LoginViewController.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerNewUserButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    private var presenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
         
    }
    
    @IBAction func registerButtonDidTouch(_ sender: UIButton) {
        self.presenter?.goRegisterViewController()
    }
}

// MARK: - Init View
extension LoginViewController {
    override func initUI() {
        
    }
}

// MARK: - Init Data
extension LoginViewController {
    override func initData() {

    }
}

// MARK: - IBAction
extension LoginViewController {
    @IBAction func loginAction(sender: UIButton) {
        self.login()
    }
}

// MARK: - ConfigPresenter
extension LoginViewController {
    override func configPresenter() {
        self.presenter = LoginPresenter.init(view: self)
    }
}

// MARK: - Private func
extension LoginViewController {
    
}

// MARK: - Public func
extension LoginViewController {
    
}

// MARK: - API CALL
extension LoginViewController {
    func login() {
        guard let userName = userNameTextField.text, userName.count > 0 else {
            AppUtil.showAlertWithMessage("Chua nhap userName")
            return
        }
        guard let password = passwordTextField.text, password.count > 0 else {
            AppUtil.showAlertWithMessage("Chua nhap pass")
            return
        }
        
        let params: [String: Any] = [kUserName: userName, kPassword: password]
        self.presenter?.login(params: params)
    }
}

// MARK: - LoginPresenterView
extension LoginViewController: LoginPresenterView {
    func goRegisterViewController() {
        let registerVC = RegisterViewController.controller(from: "Register", storyboardID: "RegisterViewController")
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func authenticationCompleted(isSuccess: Bool) {
        AppUtil.appDelegate?.setupRootHomeVC()
    }
}

