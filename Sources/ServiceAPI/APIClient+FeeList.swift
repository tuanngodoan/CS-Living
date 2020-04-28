//
//  APIClient+FeeList.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/28/20.
//

import Foundation

extension APIClient {
    func getFeeList(param: [String: Any], callBack: @escaping CSCallBack) {
        requestPath(path: kGetBalanceCD, param: param, methodRequest: .post, callback: callBack)
    }
    
    func getSearchServiceBy(param: [String: Any], callBack: @escaping CSCallBack) {
        requestPath(path: kSearchServiceBy, param: param, methodRequest: .post, callback: callBack)
    }
}
