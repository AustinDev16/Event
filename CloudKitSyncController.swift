
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
        
        let allEventHandles = user.eventHandles.flatMap { $0 as? EventHandle }
        
        // MARK: - events Created by USER
        let eventsUserCreated = allEventHandles.filter { $0.eventType == EventType.createdByUser.rawValue }
        
        
        
        for event in eventsUserCreated {
            
            let predicate = NSPredicate(format: "eventID == %@", event.eventID)
            CloudKitManager.sharedController.fetchRecordsWithType(Event.recordType, predicate: predicate, recordFetchedBlock: nil, completion: { (eventRecords, error) in
                DispatchQueue.main.async {
                    
                    if error != nil {
                        print( "Error fetching events from user list")
                    }
                    
                    guard let eventRecords = eventRecords else { return }
                    
                    for eventRecord in eventRecords {
                        if let newEvent = Event(record: eventRecord) {
                            CloudKitSyncController.shared.getChecklists(forEvent: newEvent)
                        }
                        
                    }
                    
                    PersistenceController.sharedController.saveToPersistedStorage()
                    let notification = Notification(name: Notification.Name(rawValue: "newEventSaved"))
                    NotificationCenter.default.post(notification)
                }
            })
        }
        
        
        // MARK: - Events the User is Invited To
        
        
        // MARK: - Events the User has been invited to
    }
    
    func getChecklists(forEvent: Event){
        
        let predicate = NSPredicate(format: "eventID == %@", forEvent.eventID)
        CloudKitManager.sharedController.fetchRecordsWithType(Checklist.recordType, predicate: predicate, recordFetchedBlock: nil) { (records, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error fetching checklist for event \(forEvent.name): \(error?.localizedDescription)")
                }
                if let records = records {
                    for record in records {
                        guard let newChecklist = Checklist(record: record) else { return }
                        PersistenceController.sharedController.saveToPersistedStorage()
                        let notification = Notification(name: Notification.Name(rawValue: "newChecklistSaved"))
                        NotificationCenter.default.post(notification)
                        CloudKitSyncController.shared.getListItems(forChecklist: newChecklist)
                    }
                }
            }
        }
        
        
    }
    
    func getListItems(forChecklist: Checklist){
        
        
        
    }
}
