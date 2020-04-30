//
//  LoginPresenter.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit
import FirebaseAuth
import CoreData

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
                        // save data firebase
                        self?.updateUserDB(user: userObject.data)
                        // save token
                        UserDefaults.standard.set("\(userObject.data.id)", forKey: kID)
                        UserDefaults.standard.set(userObject.token ?? "", forKey: kAccessToken)
                        UserDefaults.standard.synchronize()
                        // save infor user with coreDat
                        self?.saveUser(userModel: userObject.data)
                        // update UI
                        self?.view?.authenticationCompleted(isSuccess: true)
                    } catch  {
                        print(error)
                    }
                }
            }
        }
    }
    
    func saveUser(userModel: UserModel) {
        let user: User = User.createUser(withId: "\(userModel.id)")
        user.setCotnent(userModel)
        DataManager.sharedIntance.saveContext()
        let curUser = User.currentUser()
        print(curUser.username)
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
