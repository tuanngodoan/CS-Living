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
                        self?.updateUserDB(user: userObject.data)
                        if let json = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                            UserDefaults.standard.set(json["token"], forKey: kAccessToken)
                        }
                        
                        self?.view?.authenticationCompleted(isSuccess: true)
                    } catch  {
                        print(error)
                    }
                }
            }
        }
    }
    
    func goRegisterViewController() {
        self.view?.goRegisterViewController()
    }
    
    func updateUserDB(user: UserModel) {
        let userDB = UserDB(blockID: user.blockID,
                            floorID: user.floorID,
                            fullName: user.firstName,
                            id: user.id,
                            isOnline: true,
                            nickName: user.username,
                            notificationToken: "ExponentPushToken[3vCtFxHH9st6gxGsrVPjFb]",
                            projectID: user.projectID,
                            unitID: user.unitID,
                            unitName: user.unitname)
        FirebaseDBManager.shared.updateUser(user: userDB) { (isDone, error) in
            if isDone && error == nil {
                print("Success update to Firebase!!")
            } else {
                print("Fail update to Firebase!!")
            }
        }
    }
}
