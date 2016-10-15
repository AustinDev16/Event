//
//  Checklist+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

@objc(Checklist)
public class Checklist: NSManagedObject {
    
    convenience init(name: String,
                     checklistID: String = NSUUID().uuidString,
                     event: Event,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.checklistID = checklistID
        self.eventID = event.eventID
        self.event = event
    }
    
    static let recordType = "Checklist"
    static let kName = "name"
    static let kChecklistID = "checklistID"
    static let kEventID = "eventID"
    
    convenience init?(record: CKRecord){
        if record.recordType != Checklist.recordType { return nil }
        guard let name = record[Checklist.kName] as? String,
        let checklistID = record[Checklist.kChecklistID] as? String,
            let eventID = record[Checklist.kEventID] as? String,
        let event = EventController.sharedController.findEvent(forID: eventID) else { return nil }
        
        self.init(name: name, checklistID: checklistID, event: event)
        self.ckRecordID = record.recordID.recordName
    }

}
