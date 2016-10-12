//
//  User+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    convenience init(name: String,
                     phoneNumber: String,
                     userID: String = NSUUID().uuidString,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.userID = userID
    }

}
