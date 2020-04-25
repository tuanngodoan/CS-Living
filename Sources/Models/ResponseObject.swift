//
//  ResponseObject.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit

final class ResponseObject: NSObject {

    var errorCode: Int = -1
    var httpCode: Int?
    var jsonString: String?
    var data: Data?
    var message: String?
    var info = [AnyHashable: Any]()
    var accessToken: String?
    
}
