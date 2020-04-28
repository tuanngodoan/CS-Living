//
//  APIClient+Register.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit
import Alamofire

extension APIClient {
    func postRegisterUser(param: Parameters, callBack: @escaping CSCallBack) {
        requestPath(path: kRegister, param: param, methodRequest: .post) { responseObject, error in
            callBack(responseObject,error)
        }
    }
    
    func getLicense(callBack: @escaping CSCallBack) {
        //requestPath(path: kGetListLicense, param: [:], methodRequest: .get, callback: callBack)
    }
}

