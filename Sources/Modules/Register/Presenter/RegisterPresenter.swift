//
//  RegisterPresenter.swift
//  CS-Living
//
//  Created by doanntuann on 4/26/20.
//

import Foundation
import FirebaseAuth

protocol RegisterPresenterView: class {
    func registerCompleted(isSuccess: Bool)
}

class RegisterPresenter {
    weak var view: RegisterPresenterView?
    
    init(view: RegisterPresenterView) {
        self.view = view
    }
    
    func register(params: [String: Any]) {
        
        var registerParams = params
        registerParams[kId] = "0"
        registerParams[kUserCode] = ""
        registerParams[kStatus] = "0"
        registerParams[kContractNo] = ""
        registerParams[kProjectId] = 1
        registerParams[kUnitName] = "string"
        registerParams[kConfigLinkCode] = "string"
        registerParams[kOwnerCode] = "string"
        registerParams[kKeyCode] = ""

        APIClient.sharedIntance.postRegisterUser(param: registerParams) {[weak self] (responseObject, error) in
            if error == nil, responseObject != nil {
                if let jsonData = responseObject?.jsonString?.data(using: .utf8) {
                    do {
                        self?.view?.registerCompleted(isSuccess: true)
                        let decoder = JSONDecoder()
                        let registerObject = try decoder.decode(NetworkResponse<RegisterModel>.self, from: jsonData)
                        let email = registerObject.data.email
                        let password = registerObject.data.password
                        self?.registerUserWithFireBase(email: email, pwd: password)
                    } catch  {
                        print(error)
                    }
                } 
            }
        }
    }
    
    func registerUserWithFireBase(email: String, pwd: String) {
        Auth.auth().createUser(withEmail: email, password: pwd) {[weak self] (result, error) in
            if let _ = result {
                self?.view?.registerCompleted(isSuccess: true)
            } else {
                self?.view?.registerCompleted(isSuccess: false)
            }
        }
    }
    
    func validInput() {
        
    }
}
