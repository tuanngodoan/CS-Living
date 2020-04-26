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
    }
    
    @IBAction func register(sender: UIButton) {
        registerUserFireBase()
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
        let params: [String: Any] = [kUserName: "string", kPassword: "string"]
        self.presenter?.login(params: params)
    }
    
    func registerUserFireBase() {
//        Auth.auth().createUser(withEmail: "tungkoi92@gmail.com", password: "thanhtung") { (result, error) in
//            print("LOGGGG",result?.user.uid)
//        }
        
        Auth.auth().signIn(withEmail: "tungkoi92@gmail.com", password: "thanhtung") { (result, error) in
            print("LOGGGGqqqq",result?.user.uid)
        }
    }
}

// MARK: - LoginPresenterView
extension LoginViewController: LoginPresenterView {
    func authenticationCompleted(isSuccess: Bool) {
        
    }
}

