//
//  HomePresenter.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/26/20.
//

import Foundation

protocol HomePresenterView: class {
    func goUpgradeAccountVC()
}

class HomePresenter {
    weak var view: HomePresenterView?
    
    init(view: HomePresenterView) {
        self.view = view
    }
    
    func goUpgradeAccountVC() {
        self.view?.goUpgradeAccountVC()
    }
}
