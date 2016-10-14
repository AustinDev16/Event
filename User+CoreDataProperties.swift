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
    @NSManaged public var eventsCreatedByUser: NSOrderedSet
    @NSManaged public var eventsAcceptedFromInvititation: NSOrderedSet
    @NSManaged public var eventsPendingAcceptance: NSOrderedSet

}

// MARK: Generated accessors for eventsCreatedByUser
extension User {

    @objc(insertObject:inEventsCreatedByUserAtIndex:)
    @NSManaged public func insertIntoEventsCreatedByUser(_ value: EventHandle, at idx: Int)

    @objc(removeObjectFromEventsCreatedByUserAtIndex:)
    @NSManaged public func removeFromEventsCreatedByUser(at idx: Int)

    @objc(insertEventsCreatedByUser:atIndexes:)
    @NSManaged public func insertIntoEventsCreatedByUser(_ values: [EventHandle], at indexes: NSIndexSet)

    @objc(removeEventsCreatedByUserAtIndexes:)
    @NSManaged public func removeFromEventsCreatedByUser(at indexes: NSIndexSet)

    @objc(replaceObjectInEventsCreatedByUserAtIndex:withObject:)
    @NSManaged public func replaceEventsCreatedByUser(at idx: Int, with value: EventHandle)

    @objc(replaceEventsCreatedByUserAtIndexes:withEventsCreatedByUser:)
    @NSManaged public func replaceEventsCreatedByUser(at indexes: NSIndexSet, with values: [EventHandle])

    @objc(addEventsCreatedByUserObject:)
    @NSManaged public func addToEventsCreatedByUser(_ value: EventHandle)

    @objc(removeEventsCreatedByUserObject:)
    @NSManaged public func removeFromEventsCreatedByUser(_ value: EventHandle)

    @objc(addEventsCreatedByUser:)
    @NSManaged public func addToEventsCreatedByUser(_ values: NSOrderedSet)

    @objc(removeEventsCreatedByUser:)
    @NSManaged public func removeFromEventsCreatedByUser(_ values: NSOrderedSet)

}

// MARK: Generated accessors for eventsAcceptedFromInvititation
extension User {

    @objc(insertObject:inEventsAcceptedFromInvititationAtIndex:)
    @NSManaged public func insertIntoEventsAcceptedFromInvititation(_ value: EventHandle, at idx: Int)

    @objc(removeObjectFromEventsAcceptedFromInvititationAtIndex:)
    @NSManaged public func removeFromEventsAcceptedFromInvititation(at idx: Int)

    @objc(insertEventsAcceptedFromInvititation:atIndexes:)
    @NSManaged public func insertIntoEventsAcceptedFromInvititation(_ values: [EventHandle], at indexes: NSIndexSet)

    @objc(removeEventsAcceptedFromInvititationAtIndexes:)
    @NSManaged public func removeFromEventsAcceptedFromInvititation(at indexes: NSIndexSet)

    @objc(replaceObjectInEventsAcceptedFromInvititationAtIndex:withObject:)
    @NSManaged public func replaceEventsAcceptedFromInvititation(at idx: Int, with value: EventHandle)

    @objc(replaceEventsAcceptedFromInvititationAtIndexes:withEventsAcceptedFromInvititation:)
    @NSManaged public func replaceEventsAcceptedFromInvititation(at indexes: NSIndexSet, with values: [EventHandle])

    @objc(addEventsAcceptedFromInvititationObject:)
    @NSManaged public func addToEventsAcceptedFromInvititation(_ value: EventHandle)

    @objc(removeEventsAcceptedFromInvititationObject:)
    @NSManaged public func removeFromEventsAcceptedFromInvititation(_ value: EventHandle)

    @objc(addEventsAcceptedFromInvititation:)
    @NSManaged public func addToEventsAcceptedFromInvititation(_ values: NSOrderedSet)

    @objc(removeEventsAcceptedFromInvititation:)
    @NSManaged public func removeFromEventsAcceptedFromInvititation(_ values: NSOrderedSet)

}

// MARK: Generated accessors for eventsPendingAcceptance
extension User {

    @objc(insertObject:inEventsPendingAcceptanceAtIndex:)
    @NSManaged public func insertIntoEventsPendingAcceptance(_ value: EventHandle, at idx: Int)

    @objc(removeObjectFromEventsPendingAcceptanceAtIndex:)
    @NSManaged public func removeFromEventsPendingAcceptance(at idx: Int)

    @objc(insertEventsPendingAcceptance:atIndexes:)
    @NSManaged public func insertIntoEventsPendingAcceptance(_ values: [EventHandle], at indexes: NSIndexSet)

    @objc(removeEventsPendingAcceptanceAtIndexes:)
    @NSManaged public func removeFromEventsPendingAcceptance(at indexes: NSIndexSet)

    @objc(replaceObjectInEventsPendingAcceptanceAtIndex:withObject:)
    @NSManaged public func replaceEventsPendingAcceptance(at idx: Int, with value: EventHandle)

    @objc(replaceEventsPendingAcceptanceAtIndexes:withEventsPendingAcceptance:)
    @NSManaged public func replaceEventsPendingAcceptance(at indexes: NSIndexSet, with values: [EventHandle])

    @objc(addEventsPendingAcceptanceObject:)
    @NSManaged public func addToEventsPendingAcceptance(_ value: EventHandle)

    @objc(removeEventsPendingAcceptanceObject:)
    @NSManaged public func removeFromEventsPendingAcceptance(_ value: EventHandle)

    @objc(addEventsPendingAcceptance:)
    @NSManaged public func addToEventsPendingAcceptance(_ values: NSOrderedSet)

    @objc(removeEventsPendingAcceptance:)
    @NSManaged public func removeFromEventsPendingAcceptance(_ values: NSOrderedSet)

}
