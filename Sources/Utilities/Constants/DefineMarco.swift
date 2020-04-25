//
//  DefineMarco.swift
//  Yeeld
//
//  Created by admin on 11/15/17.
//  Copyright © 2017 Tung Dang. All rights reserved.
//

import Foundation
import UIKit

//- mark DEVICE INFORMATION
#if DEBUG
    //#define DEBUGLOG(...)  NSLog(__VA_ARGS__)
#else
    //#define DEBUGLOG(...)  ;
#endif

public func SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(version: String) -> Bool {
    return UIDevice.current.systemVersion.compare(version, options: .numeric) == ComparisonResult.orderedDescending
}
// MARK: - SCREEN INFORMATION
/** Float: Portrait Screen Height **/
let SCREEN_HEIGHT_PORTRAIT      =            UIScreen.main.bounds.size.height
let SCREEN_HEIGHT_PORTRAIT_MAIN =            667
/** Float: Portrait Screen Width **/
let SCREEN_WIDTH_PORTRAIT       =            UIScreen.main.bounds.size.width
/** Float: Landscape Screen Height **/
let SCREEN_HEIGHT_LANDSCAPE     =           UIScreen.main.bounds.size.width
/** Float: Landscape Screen Width **/
let SCREEN_WIDTH_LANDSCAPE      =           UIScreen.main.bounds.size.height

public func SETLOCALIZED(string: String) -> String {
    return string//NSLocalizedString(string, comment: "")
}

typealias ResponseFromAPI = (Data, error: Data)
