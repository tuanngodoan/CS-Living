//
//  Router.swift
//  CS-Living
//
//  Created by ThanhTung on 4/25/20.
//

import UIKit

protocol Router: class {
    associatedtype Context
    func execute(in context: Context)
    
}
