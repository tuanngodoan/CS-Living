//
//  NotificationModel.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/29/20.
//

import Foundation
struct NotifiModel: Codable {
    var id : Int?
    var request : String?
    var respone : String?
    var timeprocess : String?
    var createdBy : String?
    var propertyID : Int?
    var blockID : Int?
    var floorID : Int?
    var unitID : Int?
    var tilte :String?
    var content : String?
    var messageType : String?
    var isRead : Int?
}

struct InfoMessageRequestField: Codable {
    var to:String?
    var notification:Notification?
    
    struct Notification: Codable {
        var body:String?
        var title:String?
    }
}

struct InfoMessageRequestFields: Codable {
    var id : Int?
    var request : String?
    var respone : String?
    var timeprocess : String?
    var createdBy : String?
    var propertyID : Int?
    var blockID : Int?
    var floorID : Int?
    var unitID : Int?
    var tilte :String?
    var content : String?
    var messageType : String?
    var isRead : Int?
}
