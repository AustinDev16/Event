//
//  Event+CoreDataProperties.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event");
    }

    @NSManaged public var name: String
    @NSManaged public var date: NSDate
    @NSManaged public var location: String
    @NSManaged public var detailDescription: String
    @NSManaged public var eventID: String
    @NSManaged public var hostID: String
    @NSManaged public var guests: NSSet
    @NSManaged public var checklists: NSSet

}

// MARK: Generated accessors for guests
extension Event {

    @objc(addGuestsObject:)
    @NSManaged public func addToGuests(_ value: Guest)

    @objc(removeGuestsObject:)
    @NSManaged public func removeFromGuests(_ value: Guest)

    @objc(addGuests:)
    @NSManaged public func addToGuests(_ values: NSSet)

    @objc(removeGuests:)
    @NSManaged public func removeFromGuests(_ values: NSSet)

}

// MARK: Generated accessors for checklists
extension Event {

    @objc(addChecklistsObject:)
    @NSManaged public func addToChecklists(_ value: Checklist)

    @objc(removeChecklistsObject:)
    @NSManaged public func removeFromChecklists(_ value: Checklist)

    @objc(addChecklists:)
    @NSManaged public func addToChecklists(_ values: NSSet)

    @objc(removeChecklists:)
    @NSManaged public func removeFromChecklists(_ values: NSSet)

}
