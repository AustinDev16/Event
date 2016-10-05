//
//  Guest+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

@objc(Guest)
public class Guest: NSManagedObject {
    
    convenience init(userName: String,
                     hasAcceptedInvite: Bool = false,
                     userID: String = "",
                     eventID: String,
                     event: Event,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.userName = userName
        self.hasAcceptedInvite = hasAcceptedInvite
        self.userID = userID
        self.eventID = eventID
        self.event = event
        
    }

}
