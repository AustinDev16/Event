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
                     phoneNumber: Int,
                     userID: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.phoneNumber = Int16(phoneNumber)
        self.userID = userID
    }

}
