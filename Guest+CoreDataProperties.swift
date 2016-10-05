//
//  Guest+CoreDataProperties.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData


extension Guest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Guest> {
        return NSFetchRequest<Guest>(entityName: "Guest");
    }

    @NSManaged public var userName: String
    @NSManaged public var hasAcceptedInvite: Bool
    @NSManaged public var userID: String
    @NSManaged public var eventID: String
    @NSManaged public var event: Event

}
