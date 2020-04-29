//
//  NetworkResponse.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit

struct NetworkResponse<ResponseData:Codable>: Codable {
    let statusCode: Int
    let messages: [String]
    let data: ResponseData
    let token: String
}
