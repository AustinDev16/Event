//
//  ListItem+CoreDataProperties.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData


extension ListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListItem> {
        return NSFetchRequest<ListItem>(entityName: "ListItem");
    }

    @NSManaged public var name: String
    @NSManaged public var isComplete: Bool
    @NSManaged public var responsibleParty: String
    @NSManaged public var checklistID: String
    @NSManaged public var eventID: String
    @NSManaged public var checklist: Checklist

}
