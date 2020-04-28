//
//  FeeModel.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/28/20.
//

import Foundation
struct FeeModel: Codable {
    var balnaceVND : Decimal?
    var openingDebit : Decimal?
    var accruedExpense : Decimal?
    var paidAmount : Decimal?
    var closingDebit : Decimal?
    var dataDetail : [FeeDetail]?
}

struct FeeDetail: Codable {
    var contractId : Int?
    var chargeCode : String?
    var description : String?
    var openingDebit : Decimal?
    var accruedExpense : Decimal?
    var paidAmount : Decimal?
    var closingDebit : Decimal?
}
