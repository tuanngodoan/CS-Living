//
//  String+Extension.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/29/20.
//

import Foundation

extension String {
    func showLocal() -> String {
        return DateFormatter().showLocal(self)
    }
}
