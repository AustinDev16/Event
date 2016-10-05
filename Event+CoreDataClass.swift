//
//  Event+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

@objc(Event)
public class Event: NSManagedObject {

    convenience init(name: String,
                     date: NSDate = NSDate(),
                     location: String = "",
                     detailDescription: String = "",
                     eventID: String = NSUUID().uuidString,
                     hostID: String = "",
                     context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.date = date
        self.location = location
        self.detailDescription = detailDescription
        self.eventID = eventID
        self.hostID = hostID
    }
}
