//
//  CloudKitSyncable.swift
//  Event
//
//  Created by Austin Blaser on 10/14/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CloudKit

extension CKRecord {
    convenience init(user: User) {
        
        self.init(recordType: User.recordType)
        self["displayName"] = user.name as CKRecordValue?
        self["phoneNumber"] = user.phoneNumber as CKRecordValue?
        self["userID"] = user.userID as CKRecordValue?
        
        self["cloudKitUserID"] = user.cloudKitUserID as CKRecordValue?
    }
}
