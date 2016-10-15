//
//  Checklist+CoreDataProperties.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData


extension Checklist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Checklist> {
        return NSFetchRequest<Checklist>(entityName: "Checklist");
    }

    @NSManaged public var name: String
    @NSManaged public var checklistID: String
    @NSManaged public var eventID: String
    @NSManaged public var listItems: NSOrderedSet
    @NSManaged public var event: Event
    @NSManaged public var ckRecordID: String?

}

// MARK: Generated accessors for listItems
extension Checklist {

    @objc(addListItemsObject:)
    @NSManaged public func addToListItems(_ value: ListItem)

    @objc(removeListItemsObject:)
    @NSManaged public func removeFromListItems(_ value: ListItem)

    @objc(addListItems:)
    @NSManaged public func addToListItems(_ values: NSSet)

    @objc(removeListItems:)
    @NSManaged public func removeFromListItems(_ values: NSSet)

}
