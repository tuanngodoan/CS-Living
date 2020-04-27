//
//  UserDB.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/27/20.
//

import Foundation

struct UserDB: Codable {
    let blockID, floorID: Int
    let fullName: String
    let id: Int
    let isOnline: Bool
    let nickName, notificationToken: String
    let projectID, unitID: Int
    let unitName: String

    enum CodingKeys: String, CodingKey {
        case blockID = "BlockId"
        case floorID = "FloorId"
        case fullName = "FullName"
        case id = "Id"
        case isOnline = "IsOnline"
        case nickName = "NickName"
        case notificationToken = "NotificationToken"
        case projectID = "ProjectId"
        case unitID = "UnitId"
        case unitName = "UnitName"
    }
}
