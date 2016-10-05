//
//  ListItem+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

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

}
