//
//  User+CoreDataProperties.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData



extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var name: String
    @NSManaged public var phoneNumber: String
    @NSManaged public var userID: String
    @NSManaged public var cloudKitUserID: String
    @NSManaged public var ckRecordID: String?
    

}
