//
//  NotificationPresenter.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/29/20.
//

import Foundation

protocol NotificationPresenterView: class {
    func getNotificationCompletion(listNotifi: [NotifiModel])
}

class NotificationPresenter {
    weak var view: NotificationPresenterView?
    
    init(view: NotificationPresenterView) {
        self.view = view
    }
    
    func getNotification(param: [String: Any]) {
        APIClient.sharedIntance.getNotification(param: param) { (responseObject, error) in
            if error == nil, responseObject != nil {
                if let jsonData = responseObject?.jsonString?.data(using: .utf8) {
                    do {
                        let decoder = JSONDecoder()
                        let listNotification = try decoder.decode(NetworkResponse<[NotifiModel]>.self, from: jsonData)
                        self.view?.getNotificationCompletion(listNotifi: listNotification.data)
                    } catch  {
                        print(error)
                    }
                }
            }
    }
    }
}
