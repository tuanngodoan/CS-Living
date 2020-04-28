//
//  LicenseModel.swift
//  CS-Living
//
//  Created by doanntuann on 4/28/20.
//

import Foundation

struct LicenseModel: Codable {
    let id: Int
    let code, name, licenseDescription: String
    let ownerCode: String
    let unit: [UnitModel]

    enum CodingKeys: String, CodingKey {
        case id, code, name
        case licenseDescription = "description"
        case ownerCode
        case unit = "unit"
    }
}

struct UnitModel: Codable {
    let id: Int
    let name: String
    let propertyID: Int
    let ownerCode: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case propertyID = "propertyId"
        case ownerCode
    }
}


