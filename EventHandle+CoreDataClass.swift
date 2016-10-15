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
    
    convenience init(event: Event, eventType: EventType, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        self.eventID = event.eventID
        self.user = UserAccountController.sharedController.hostUser
        self.eventType = eventType.rawValue
        
    }
    
    convenience init(eventID: String, eventType: String, context: NSManagedObjectContext = CoreDataStack.context){
        self.init(context: context)
        
        self.eventID = eventID
        self.eventType = eventType
        self.user = UserAccountController.sharedController.hostUser

    }

}

public enum EventType: String {
    case createdByUser
    case acceptedFromInvite
    case pendingInvite
}
