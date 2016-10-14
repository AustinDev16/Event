//
//  EventHandle+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/14/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData


public class EventHandle: NSManagedObject {
    
    convenience init(event: Event, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.eventID = event.eventID
    }

}
