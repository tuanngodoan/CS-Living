//
//  APIClient+Login.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit
import Alamofire
extension APIClient {
    func login(param: Parameters, callBack: @escaping CSCallBack) {
        requestPath(path: kLogin, param: param, methodRequest: .post) { responseObject, error in
            callBack(responseObject,error)
        }
    }
}
