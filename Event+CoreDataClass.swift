//
//  Event+CoreDataClass.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

@objc(Event)
public class Event: NSManagedObject {

    convenience init(name: String,
                     date: NSDate = NSDate(),
                     location: String,
                     detailDescription: String,
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
    
    static let recordType = "Event"
    static let kName = "name"
    static let kDate = "date"
    static let kLocation = "location"
    static let kDetailDescription = "detailDescription"
    static let kEventID = "eventID"
    static let kHostID = "hostID"
    
    convenience init?(record: CKRecord){
        guard let name = record[Event.kName] as? String,
        let date = record[Event.kDate] as? NSDate,
        let location = record[Event.kLocation] as? String,
        let detailDescription = record[Event.kDetailDescription] as? String,
        let eventID = record[Event.kEventID] as? String,
            let hostID = record[Event.kHostID] as? String else { return nil }
        
        self.init(name: name, date: date, location: location, detailDescription: detailDescription, eventID: eventID, hostID: hostID)
        self.ckRecordID = record.recordID.recordName
        
        
    }
}
