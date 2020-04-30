//
//  APIClient.swift
//  Yeeld
//
//  Created by admin on 11/30/17.
//  Copyright © 2017 Tung Dang. All rights reserved.
//

import UIKit
import Alamofire
import SystemConfiguration
import MBProgressHUD

typealias CSCallBack = (ResponseObject?, Error?) -> Void

final class APIClient: Session {
    static let sharedIntance = APIClient()
    /*
     * Handle Success Operation
     */
    
    func handleResponseData(callback: (Data?, Error?)) {
        
    }
    
    class func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }

    func getRequestPath (path: String, param: Parameters?, showLoading: Bool = true, callback: @escaping CSCallBack) {
        if !APIClient.isInternetAvailable() {
            AppUtil.showAlertWithMessage(kLostInternet)
            let errorTemp = NSError(domain: "", code: 10000, userInfo: nil)
            callback(ResponseObject(), errorTemp as Error)
            return
        }
        let urlString = kBaseServerDev.appending(path)
        if showLoading {
            MBProgressHUD.showAdded(to: AppUtil.visibleViewController?.view ?? UIView(), animated: true)
        }
        
        AF.request(urlString, parameters: param, headers: getHeader()).responseData { (response) in
            MBProgressHUD.hide(for: AppUtil.visibleViewController?.view ?? UIView(), animated: true)
            self.processResponse(response: response, callBack: callback)
        }
    }
    
    func requestPath(path: String, param: Parameters, methodRequest: HTTPMethod, callback: @escaping CSCallBack) {

        if !APIClient.isInternetAvailable() {
            AppUtil.showAlertWithMessage(kLostInternet)
            let errorTemp = NSError(domain: "", code: 10000, userInfo: nil)
            callback(ResponseObject(), errorTemp as Error)
            return
        }
        let urlString = kBaseServerDev.appending(path)
        MBProgressHUD.showAdded(to: AppUtil.visibleViewController?.view ?? UIView(), animated: true)
        
        AF.request(urlString, method: methodRequest, parameters: param, encoding: JSONEncoding.default, headers: getHeader()).responseData(completionHandler: { response in
            MBProgressHUD.hide(for: AppUtil.visibleViewController?.view ?? UIView(), animated: true)
            self.processResponse(response: response, callBack: callback)
        })
    }
    
    func requestPath(path: String, param: Parameters, methodRequest: HTTPMethod, encoding: ParameterEncoding, callback: @escaping CSCallBack) {

        if !APIClient.isInternetAvailable() {
            AppUtil.showAlertWithMessage(kLostInternet)
            let errorTemp = NSError(domain: "", code: 10000, userInfo: nil)
            callback(ResponseObject(), errorTemp as Error)
            return
        }
        let urlString = kBaseServerDev.appending(path)
        MBProgressHUD.showAdded(to: AppUtil.visibleViewController?.view ?? UIView(), animated: true)
        
        AF.request(urlString, method: methodRequest, parameters: param, encoding: encoding, headers: getHeader()).responseData(completionHandler: { response in
            MBProgressHUD.hide(for: AppUtil.visibleViewController?.view ?? UIView(), animated: true)
            self.processResponse(response: response, callBack: callback)
        })
    }
}

private extension APIClient {

    func addObjectToMutilPart(_ param: Parameters, multipartFormData: MultipartFormData) {
        let total = param.keys.count
        if total > 0 {
            for (key, value) in param {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
        }

        let timestamp = "\(Date().timeIntervalSince1970)"
        for key in param.keys {
            if let image: UIImage = param[key] as? UIImage {
                var dataImage: Data?
                guard let resizeImage = image.resizedImage() else { return }
                if let data = resizeImage.jpegData(compressionQuality: 1.0), image.size.width > 0 {
                    dataImage = data
                }
                if let dataImage = dataImage {
                    multipartFormData.append(dataImage, withName: key, fileName: "img_\(timestamp).png", mimeType: "image/png")
                }
            }
        }
    }

    func getHeader() -> HTTPHeaders {
        var parameters: HTTPHeaders
        let accessToken: String = UserDefaults.standard.value(forKey: kAccessToken) as? String ?? ""
        parameters = ["Content-Type": "application/json",
                      "Accept": "application/json",
                      "Authorization":"Bearer \(accessToken)"] as HTTPHeaders? ?? HTTPHeaders()
        
        return parameters
    }

    func processResponse(response: AFDataResponse<Data>, callBack: @escaping CSCallBack) {
        switch response.result {
        case .success(let data):
            debugPrint("data: \(data)")
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                let respon = response.description
                print("Description: \(respon)")
                print("Data: \(utf8Text)")
                
                let responseObject = ResponseObject()
                
                if response.response?.statusCode == 200 {
                    responseObject.httpCode = (response.response?.statusCode)!
                    if let tempDict = AppUtil.convertToDictionary(text: utf8Text) {
                        responseObject.message = "Success"
                        if let errorCode = tempDict["code"] as? Int {
                            responseObject.errorCode = errorCode
                            debugPrint(errorCode)
                        }
                    } else {
                        responseObject.message = "Fail"
                    }
                    responseObject.data = response.data
                    responseObject.jsonString = utf8Text
                    responseObject.accessToken = response.response?.allHeaderFields["Authorization"] as? String
                } else {
                    //  responseObject.message = kCallAPIFailed
                }
                if responseObject.errorCode != 0 {
                    showErrorMessage(utf8Text)
                }
                callBack(responseObject, nil)
            }
        case .failure(let error):
            callBack(ResponseObject(), error)
            print("Error \(error)")
        }
    }

    func showErrorMessage(_ message: String?) {
        if let data = message?.data(using: .utf8) {
            do {
                let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                AppUtil.showAlertWithMessage(dict?["error_message"] as? String ?? "")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
