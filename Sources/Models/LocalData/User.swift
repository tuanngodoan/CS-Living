//
//  User.swift
//  POS iPAD
//
//  Created by admin on 7/3/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import CoreData

@objc(User)
final class User: NSManagedObject {
    @NSManaged var id: String?
    @NSManaged var username: String?
    @NSManaged var firstName: String?
    @NSManaged var midName: String?
    @NSManaged var lastName: String?
    @NSManaged var projectID: String?
    @NSManaged var unitID: String?
    @NSManaged var unitname: String?
    @NSManaged var contractID: String?
    @NSManaged var contractNo: String?
    @NSManaged var blockName: String?
    @NSManaged var blockID: String?
    @NSManaged var floor: String?
    @NSManaged var floorID: String?
    @NSManaged var projectCode: String?
    @NSManaged var projectName: String?
    @NSManaged var ownerCode: String?
    @NSManaged var configLinkCode: String?
    
    
}

extension User {
    class func currentUser() -> User {
        let user: User = User()
        guard let userId: String = UserDefaults.standard.value(forKey: kID) as? String
            else {
                return user
        }
        let context = DataManager.sharedIntance.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "\(kID) = %@", userId)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try context.fetch(request) as? [User], let curUser = result.first {
                return curUser
            }
        } catch {
            print("Failed")
        }
        return user
    }
    
    class func createUser(withId ids: String) -> User {
        
        let context = DataManager.sharedIntance.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "\(kID) = %@", ids)
        request.returnsObjectsAsFaults = false
        do {
            if let result = try context.fetch(request) as? [User], let curUser = result.first {
                return curUser
            }
        } catch {
            
            print("Failed")
        }
        if let entity = NSEntityDescription.entity(forEntityName: "User", in: context), let newUser: User = NSManagedObject(entity: entity, insertInto: context) as? User {
            return newUser
        }
        return User()
    }
    
    func setCotnent(_ content: UserModel) {
        id = "\(content.id)";
        username = content.username
        midName = content.midName
        firstName = content.firstName
        lastName = content.lastName
        projectID = "\(content.projectID)"
        unitID = "\(content.unitID)"
        unitname = "\(content.unitname)"
        contractID = "\(content.contractID)"
        contractNo = content.contractNo
        blockName = content.blockName
        blockID = "\(content.blockID)"
        floor = content.floor
        floorID = "\(content.floorID)"
        projectCode = content.projectCode
        projectName = content.projectName
        ownerCode = content.ownerCode
        configLinkCode = content.configLinkCode
    }
}
