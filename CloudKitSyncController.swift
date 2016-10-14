
//
//  CloudKitSyncController.swift
//  Event
//
//  Created by Austin Blaser on 10/13/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitSyncController {
    static let shared = CloudKitSyncController()
    
    func getEventsFromUserAccount(){
        guard let user = UserAccountController.sharedController.hostUser else { return }
        
        let allEventHandles = user.eventHandles.flatMap { $0 as? String }
        let eventsUserCreated = allEventHandles.filter { $0 == EventType.createdByUser.rawValue }
        for event in eventsUserCreated {
            
            let predicate = NSPredicate(format: "eventID == %@", event)
            CloudKitManager.sharedController.fetchRecordsWithType(Event.recordType, predicate: predicate, recordFetchedBlock: nil, completion: { (eventRecords, error) in
                DispatchQueue.main.async {
                    
                    if error != nil {
                        print( "Error fetching events from user list")
                    }
                    
                    guard let eventRecords = eventRecords else { return }
                    
                    for eventRecord in eventRecords {
                         let _ = Event(record: eventRecord)
                    }
                    
                    PersistenceController.sharedController.saveToPersistedStorage()
                    let notification = Notification(name: Notification.Name(rawValue: "newEventSaved"))
                    NotificationCenter.default.post(notification)
                }
            })
        }
    }
}
