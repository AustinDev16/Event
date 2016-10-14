//
//  User+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

@objc(User)
public class User: NSManagedObject {
    
    convenience init(name: String,
                     phoneNumber: String,
                     userID: String = NSUUID().uuidString,
                     cloudKitUserID: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.phoneNumber = phoneNumber
        self.userID = userID
        self.cloudKitUserID = cloudKitUserID
    }
    
    // MARK: - CloudKit
    
    static var recordType: String = "userAccount"
    
    convenience init?(record: CKRecord){
        guard let name = record["displayName"] as? String,
        let phoneNumber = record["phoneNumber"] as? String,
        let userID = record["userID"] as? String,
        let cloudKitUserID = record["cloudKitUserID"] as? String else { return nil }
        
        self.init(name: name, phoneNumber: phoneNumber, userID: userID, cloudKitUserID: cloudKitUserID)
        
    }

}
