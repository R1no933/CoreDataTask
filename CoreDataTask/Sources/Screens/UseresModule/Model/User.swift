//
//  Users.swift
//  CoreDataTask
//
//  Created by Dmitriy Baskakov on 12.09.2022.
//

import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {
    @NSManaged public var avatar: Data?
    @NSManaged public var birthDay: Date?
    @NSManaged public var gender: String?
    @NSManaged public var name: String?
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
}
