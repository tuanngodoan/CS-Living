//
//  DefineKey.swift
//  Yeeld
//
//  Created by admin on 11/15/17.
//  Copyright © 2017 Tung Dang. All rights reserved.
//

import Foundation

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
// MARK: - Define Key
let kUserName                           = "Username"
let kPassword                           = "Password"
let kAccessToken                        = "accessToken"
