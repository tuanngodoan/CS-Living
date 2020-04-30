//
//  UserModel.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit

struct UserModel: Codable {
    let id: Int
    let username: String
    let firstName, midName, lastName: String?
    let projectID, unitID: Int
    let unitname: String
    let contractID: Int
    let contractNo, blockName: String
    let blockID: Int
    let floor: String
    let floorID: Int
    let projectCode, projectName, ownerCode, configLinkCode: String
    
    enum CodingKeys: String, CodingKey {
        case id, username, firstName, midName, lastName
        case projectID = "projectId"
        case unitID = "unitId"
        case unitname
        case contractID = "contractId"
        case contractNo, blockName
        case blockID = "blockId"
        case floor
        case floorID = "floorId"
        case projectCode, projectName, ownerCode, configLinkCode
    }
}
