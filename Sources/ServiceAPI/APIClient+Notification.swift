//
//  APIClient+Notification.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/29/20.
//

import Foundation
import Alamofire

extension APIClient {
    func getNotification(param: [String: Any], callBack: @escaping CSCallBack) {
        requestPath(path: kNotification, param: param, methodRequest: .post, callback: callBack)
    }
}
