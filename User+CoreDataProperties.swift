//
//  User+CoreDataProperties.swift
//  Event
//
//  Created by Austin Blaser on 10/14/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User");
    }

    @NSManaged public var cloudKitUserID: String
    @NSManaged public var name: String
    @NSManaged public var phoneNumber: String
    @NSManaged public var userID: String
    @NSManaged public var ckRecordID: String?
    @NSManaged public var eventHandles: NSOrderedSet

}

// MARK: Generated accessors for eventHandles
extension User {

    @objc(insertObject:inEventHandlesAtIndex:)
    @NSManaged public func insertIntoEventHandles(_ value: EventHandle, at idx: Int)

    @objc(removeObjectFromEventHandlesAtIndex:)
    @NSManaged public func removeFromEventHandles(at idx: Int)

    @objc(insertEventHandles:atIndexes:)
    @NSManaged public func insertIntoEventHandles(_ values: [EventHandle], at indexes: NSIndexSet)

    @objc(removeEventHandlesAtIndexes:)
    @NSManaged public func removeFromEventHandles(at indexes: NSIndexSet)

    @objc(replaceObjectInEventHandlesAtIndex:withObject:)
    @NSManaged public func replaceEventHandles(at idx: Int, with value: EventHandle)

    @objc(replaceEventHandlesAtIndexes:withEventHandles:)
    @NSManaged public func replaceEventHandles(at indexes: NSIndexSet, with values: [EventHandle])

    @objc(addEventHandlesObject:)
    @NSManaged public func addToEventHandles(_ value: EventHandle)

    @objc(removeEventHandlesObject:)
    @NSManaged public func removeFromEventHandles(_ value: EventHandle)

    @objc(addEventHandles:)
    @NSManaged public func addToEventHandles(_ values: NSOrderedSet)

    @objc(removeEventHandles:)
    @NSManaged public func removeFromEventHandles(_ values: NSOrderedSet)

}
