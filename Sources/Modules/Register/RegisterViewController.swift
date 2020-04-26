//
//  RegisterViewController.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/25/20.
//

import UIKit

class RegisterViewController: BaseViewController {

    private var presenter: RegisterPresenter!
    
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
    
    private var isCheckedTerm: Bool = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Đăng kí tài khoản"
        self.setBackButtonWithImage("icn_back", withAction: #selector(backButtonAction))
        
        let tapTerm = UITapGestureRecognizer(target: self, action: #selector(toggleCheckTerm))
        checkTermImage.addGestureRecognizer(tapTerm)
    }

    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
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
    @objc private func toggleCheckTerm() {
        self.isCheckedTerm = !self.isCheckedTerm
        self.checkTermImage.image = self.isCheckedTerm ? UIImage(named: "icn_check") : UIImage(named: "icn_uncheck")
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
        AppUtil.showAlert("Đã đăng kí tài khoản thành công", callback: { [weak self] in
            self?.backButtonAction()
        })
    }
}
