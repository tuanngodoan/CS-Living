//
//  FirebaseDBManager.swift
//  CS-Living
//
//  Created by ngo.doan.tuan on 4/27/20.
//

import Foundation
import Firebase

extension Encodable {
    var values: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}


class FirebaseDBManager {
    static let shared = FirebaseDBManager()
    var ref: DatabaseReference?
    
    func updateUser(user: UserDB, completion: @escaping (Bool, Error?)->(Void)) {
        let ref = Database.database().reference().child(kUser).child("\(kUser)-\(user.id)")
        if let value = user.values {
            ref.updateChildValues(value) { (error, ref) in
                completion(true, error)
            }
        } else {
            completion(false, nil)
        }
    }
}
