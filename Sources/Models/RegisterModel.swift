//
//  RegisterModel.swift
//  CS-Living
//
//  Created by doanntuann on 4/26/20.
//

import Foundation

// MARK: - DataClass
struct RegisterModel: Codable {
    let id: Int
    let userCode, firstName, midName, lastName: String
    let phoneNumber, email, loginName, password: String
    let status: Int
    let contractNo: String
    let projectID: Int
    let unitName, configLinkCode, ownerCode, keyCode: String

    enum CodingKeys: String, CodingKey {
        case id, userCode, firstName, midName, lastName, phoneNumber, email, loginName, password, status, contractNo
        case projectID = "projectId"
        case unitName, configLinkCode, ownerCode, keyCode
    }
}
