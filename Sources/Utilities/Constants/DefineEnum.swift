//
//  DefineEnum.swift
//  Yeeld
//
//  Created by admin on 11/15/17.
//  Copyright © 2017 Tung Dang. All rights reserved.
//

import Foundation

public enum TypeMethod: Int {
    case put = 1
    case post = 2
    case get = 3
    case delete = 4
}

struct CellKeys {
    
}


public enum ButtonHomeType: Int {
    case feeList                = 1000001 // bảng kê phí
    case feedback               = 1000002 // ý kiến yêu cầu
    case notify                 = 1000003 // thông báo
    case mediaInfomation        = 1000004 //thông tin phương tiện
    case demographicInformation = 1000005 // thông tin nhân khẩu
    case bookAService           = 1000006 // Đặt dịch vụ
    case forSale                = 1000007 //Cho thuê, bán
    case schedule               = 1000008 // Đặt lịch
    case pay                    = 1000009 // Thanh toán
}
