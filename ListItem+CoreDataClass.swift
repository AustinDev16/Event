//
//  ListItem+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

@objc(ListItem)
public class ListItem: NSManagedObject {
    
    convenience init(name: String,
                     isComplete: Bool = false,
                     responsibleParty: String,
                     checklist: Checklist,
                     event: Event,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.isComplete = isComplete
        self.responsibleParty = responsibleParty
        self.checklistID = checklist.checklistID
        self.eventID = event.eventID
        self.checklist = checklist
    }
    
    // CloudKit
    static let recordType = "ListItem"
    static let kName = "name"
    static let kIsComplete = "isComplete"
    static let kResponsibleParty = "responsibleParty"
    static let kChecklistID = "checklistID"
    static let kEventID = "eventID"
    
    convenience init?(record: CKRecord){
        if record.recordType != ListItem.recordType { return nil }
        guard let name = record[ListItem.kName] as? String,
        let isComplete = record[ListItem.kIsComplete] as? Bool,
        let responsibleParty = record[ListItem.kResponsibleParty] as? String,
        let checklistID = record[ListItem.kChecklistID] as? String,
        let eventID = record[ListItem.kEventID] as? String,
        let checklist = ChecklistController.sharedController.findChecklist(forID: checklistID, eventID: eventID) else { return nil }
        
        self.init(context: CoreDataStack.context)
        self.name = name
        self.isComplete = isComplete
        self.responsibleParty = responsibleParty
        self.checklistID = checklistID
        self.eventID = eventID
        self.checklist = checklist
        
    }
    

}
