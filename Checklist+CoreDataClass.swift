//
//  Checklist+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

@objc(Checklist)
public class Checklist: NSManagedObject {
    
    convenience init(name: String,
                     checklistID: String,
                     event: Event,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.checklistID = checklistID
        self.eventID = event.eventID
        self.event = event
    }

}
