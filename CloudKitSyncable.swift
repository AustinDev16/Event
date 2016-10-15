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
    // Mark: - User
    convenience init(user: User) {
        self.init(recordType: User.recordType)
        
        self[User.kDisplayName] = user.name as CKRecordValue?
        self[User.kPhoneNumber] = user.phoneNumber as CKRecordValue?
        self[User.kUserID] = user.userID as CKRecordValue?
        self[User.kCloudKitUserID] = user.cloudKitUserID as CKRecordValue?
        let eventsArray = EventController.sharedController.generateHostUsersEventHandlesArray()
        self[User.kEventHandles] = eventsArray as CKRecordValue?
    }
    
    convenience init(updatedUserWithRecordID: User){
        let recordID = CKRecordID(recordName: updatedUserWithRecordID.ckRecordID!)
        self.init(recordType: User.recordType, recordID: recordID)
        
        self[User.kDisplayName] = updatedUserWithRecordID.name as CKRecordValue?
        self[User.kPhoneNumber] = updatedUserWithRecordID.phoneNumber as CKRecordValue?
        self[User.kUserID] = updatedUserWithRecordID.userID as CKRecordValue?
        self[User.kCloudKitUserID] = updatedUserWithRecordID.cloudKitUserID as CKRecordValue?
        
        let eventsArray = EventController.sharedController.generateHostUsersEventHandlesArray()
        self[User.kEventHandles] = eventsArray as CKRecordValue?
    }
    
    // MARK: - Event
    convenience init(event: Event){
        self.init(recordType: Event.recordType)
        
        self[Event.kName] = event.name as CKRecordValue?
        self[Event.kDetailDescription] = event.detailDescription as CKRecordValue?
        self[Event.kDate] = event.date as CKRecordValue?
        self[Event.kLocation] = event.location as CKRecordValue?
        self[Event.kEventID] = event.eventID as CKRecordValue?
        self[Event.kHostID] = event.hostID as CKRecordValue?
     }
    
    convenience init(updatedEventWithRecordID: Event){
        let recordID = CKRecordID(recordName: updatedEventWithRecordID.ckRecordID!)
        self.init(recordType: Event.recordType, recordID: recordID)
        
        self[Event.kName] = updatedEventWithRecordID.name as CKRecordValue?
        self[Event.kDetailDescription] = updatedEventWithRecordID.detailDescription as CKRecordValue?
        self[Event.kDate] = updatedEventWithRecordID.date as CKRecordValue?
        self[Event.kLocation] = updatedEventWithRecordID.location as CKRecordValue?
        self[Event.kEventID] = updatedEventWithRecordID.eventID as CKRecordValue?
        self[Event.kHostID] = updatedEventWithRecordID.hostID as CKRecordValue?
        
    }
    
    // MARK: - Checklist
    convenience init(checklist: Checklist) {
        self.init(recordType: Checklist.recordType)
        
        self[Checklist.kName] = checklist.name as CKRecordValue?
        self[Checklist.kChecklistID] = checklist.checklistID as CKRecordValue?
        self[Checklist.kEventID] = checklist.eventID as CKRecordValue?
    }
    
    convenience init(updatedChecklistWithRecordID: Checklist) {
        let recordID = CKRecordID(recordName: updatedChecklistWithRecordID.ckRecordID!)
        self.init(recordType: Checklist.recordType, recordID: recordID)
        
        self[Checklist.kName] = updatedChecklistWithRecordID.name as CKRecordValue?
        self[Checklist.kChecklistID] = updatedChecklistWithRecordID.checklistID as CKRecordValue?
        self[Checklist.kEventID] = updatedChecklistWithRecordID.eventID as CKRecordValue?
    }
    
}
