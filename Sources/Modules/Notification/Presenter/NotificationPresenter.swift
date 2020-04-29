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
        /*APIClient.sharedIntance.getNotification(param: param) { (responseObject, error) in
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
    }*/
        
        let no1 = NotifiModel(id: 36,
                              request:"{\"to\":\"/topics/073075082066118088086072102106048061\",\"notification\":{\"body\":\"Xong\",\"title\":\"Thông báo cắt điện\"}}",
                              respone:  "",
                              timeprocess: "2020-04-25T10:29:45.26",
                              createdBy: "support2",
                              propertyID: 1,
                              blockID: 0, floorID: 0, unitID: 0,
                              tilte: "Thông báo cắt điện",
                              content: "xong", messageType: "", isRead: 0)
        
        let no2 = NotifiModel(id: 35,
        request:"{\"to\":\"/topics/073075082066118088086072102106048061\",\"notification\":{\"body\":\"Thông báo 2504\",\"title\":\"Thông báo 2504\"}}",
        respone: "",
        timeprocess: "2020-04-25T10:29:45.26",
        createdBy: "support2",
        propertyID: 1,
        blockID: 0, floorID: 0, unitID: 0,
        tilte: "Thông báo 2504n",
        content: "Thông báo 2504", messageType: "", isRead: 0)
        
        let list = [no1, no2]
        self.view?.getNotificationCompletion(listNotifi: list)
    }
}
