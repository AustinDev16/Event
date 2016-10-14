//
//  EventHandle+CoreDataProperties.swift
//  Event
//
//  Created by Austin Blaser on 10/14/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData


extension EventHandle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventHandle> {
        return NSFetchRequest<EventHandle>(entityName: "EventHandle");
    }

    @NSManaged public var eventID: String
    @NSManaged public var eventType: String
    @NSManaged public var user: User?

}
