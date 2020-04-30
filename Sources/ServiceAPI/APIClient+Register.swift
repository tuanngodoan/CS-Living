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
        getRequestPath(path: kGetListLicense, param: [:], callback: callBack)
        
//         AF.request("http://103.101.161.117:8004/api/v1/GetListLicense", method: .get, parameters: nil)
//            .responseJSON { (response) in
//
//                if let data = response.data, let utf8Text = String(data: data, encoding: .utf8)
//                {
//                print("LOGGG")
//                }
//
//
//        }
        
    }
}

