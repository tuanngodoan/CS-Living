//
//  FeePresenter.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/28/20.
//

import Foundation

protocol FeePresenterView: class {
    func getListServiceCompletion(feeList: FeeModel)
}

class FeePresenter {
    weak var view: FeePresenterView?
       
    init(view: FeePresenterView) {
        self.view = view
    }
    
    func getListService(param: [String: Any]) {
//        APIClient.sharedIntance.getFeeList(param: param) { (responseObject, error) in
//            if error == nil, responseObject != nil {
//                if let jsonData = responseObject?.jsonString?.data(using: .utf8) {
//                    do {
//                        let decoder = JSONDecoder()
//                        let object = try decoder.decode(NetworkResponse<FeeModel>.self, from: jsonData)
//
//
//                        self.view?.getListServiceCompletion(feeList: object.data)
//                    } catch  {
//                        print(error)
//                    }
//                }
//            }
//        }
        self.view?.getListServiceCompletion(feeList: dummyData())
    }
    
    func dummyData() -> FeeModel {
        let feeDetail = FeeDetail(contractId: 514,
                                  chargeCode: "",
                                  description: "TT xe máy T10/2017 BKS 29A102804",
                                  openingDebit: -2058558,
                                  accruedExpense: 0,
                                  paidAmount: 0,
                                  closingDebit: -2058558)
        let feeData = FeeModel(balnaceVND: 0,
                               openingDebit: -2058558,
                               accruedExpense: 0,
                               paidAmount: 0,
                               closingDebit: -2058558,
                               dataDetail: [feeDetail])
        return feeData
    }
    
    
}
