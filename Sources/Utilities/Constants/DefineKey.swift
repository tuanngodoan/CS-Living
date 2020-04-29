//
//  DefineKey.swift
//  Yeeld
//
//  Created by admin on 11/15/17.
//  Copyright © 2017 Tung Dang. All rights reserved.
//

import Foundation
import UIKit

// Constants

let ScreenHeight                    = UIScreen.main.bounds.size.height

//JSON Keys

let kJSONSuccess                    = 200
let kJSONCreatedSuccess             = 201
let kJSONDeletedSuccess             = 204
let kJSONInternalNetworkError       = 500
let kJSONParseError                 = -1
let kJSONUnauthorizedError          = 401
let kJSONForbiddenError             = 403
let kJSONPaymentRequiredError       = 402
let kJSONPreconditionFailedError    = 412
let kJSONRequestTimeoutError        = 408
let kJSONConflictError              = 409
let kJSONBadRequestError            = 400
let kJSONNotFoundError              = 404
let kJSONNoInternetConnection       = 0

// MARK: - Define Notification Key

// MARK: - Define Path

let kRegister                           = "/api/v1/Register"
let kLogin                              = "/api/v1/UsersLogin"
let kGetListLicense                     = "/api/v1/GetListLicense"
let kNotification                       = "/api/v1/GetLogInforMessageByModel"
// MARK: - Define Key
let kUserName                           = "Username"
let kPassword                           = "Password"
let kAccessToken                        = "accessToken"
// MARK: - Define Register Key
let kId                                 = "Id"
let kUserCode                           = "UserCode"
let kFirstName                          = "FirstName"
let kMidName                            = "MidName"
let kLastName                           = "LastName"
let kPhoneNumber                        = "PhoneNumber"
let kEmail                              = "Email"
let kLoginName                          = "LoginName"
let kStatus                             = "Status"
let kContractNo                         = "ContractNo"
let kProjectId                          = "ProjectId"
let kUnitName                           = "UnitName"
let kConfigLinkCode                     = "ConfigLinkCode"
let kOwnerCode                          = "OwnerCode"
let kKeyCode                            = "KeyCode"

let kPropertyID                         = "propertyID"
let kBlockID                            = "blockID"
let kFloorID                            = "floorID"
let kUnitID                             = "unitID"

// MARK: - Firebase key

let kUser                               = "users"
