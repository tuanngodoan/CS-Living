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
    private var presenter: LoginPresenter?
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var textFieldView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerNewUserButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
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
        let params: [String: Any] = [kUserName: "duongna167@gmail.com", kPassword: "123456"]
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
        AppUtil.appDelegate?.showHome()
    }
}

