//
//  LoginPresenter.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit
import FirebaseAuth

protocol LoginPresenterView: class {
    func authenticationCompleted(isSuccess: Bool)
    func goRegisterViewController()
}

class LoginPresenter {
    weak var view: LoginPresenterView?
    
    init(view: LoginPresenterView) {
        self.view = view
    }
    
    func login(params: [String: Any]) {
        APIClient.sharedIntance.login(param: params) {[weak self] (responseObject, error) in
            if error == nil, responseObject != nil {
                if let jsonData = responseObject?.jsonString?.data(using: .utf8) {
                    do {
                        let decoder = JSONDecoder()
                        let userObject = try decoder.decode(NetworkResponse<UserModel>.self, from: jsonData)
                        self?.loginUserWithFireBase(email: "tungkoi92@gmail.com", pwd: "thanhtung")
                    } catch  {
                        print(error)
                    }
                }
            }
        }
    }
    
    func loginUserWithFireBase(email: String, pwd: String) {
        Auth.auth().signIn(withEmail: email, password: pwd) {[weak self] (result, error) in
            if let _ = result {
                self?.view?.authenticationCompleted(isSuccess: true)
            } else {
                self?.view?.authenticationCompleted(isSuccess: false)
            }
        }
    }
    
    func goRegisterViewController() {
        self.view?.goRegisterViewController()
    }
}
