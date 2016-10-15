
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
        let predicate = NSPredicate(format: "checklistID == %@", forChecklist.checklistID)
        CloudKitManager.sharedController.fetchRecordsWithType(ListItem.recordType, predicate: predicate, recordFetchedBlock: { (record) in
            DispatchQueue.main.async {
                if let newListItem = ListItem(record: record) {
                    forChecklist.addToListItems(newListItem)
                    PersistenceController.sharedController.saveToPersistedStorage()
                    let notification = Notification(name: Notification.Name(rawValue:"newItemListSaved" ))
                    NotificationCenter.default.post(notification)
                }
            }
            }) { (_, error) in
                DispatchQueue.main.async {
                if error != nil {
                    print("Error fetching listItems: \(error?.localizedDescription)")
                }
                }
        }
        
    }
    
    func deleteEvent(event: Event){
        var recordsToDelete: [CKRecordID]  = []
        var recordIDS: [String?] = []
        // Event
        recordIDS.append(event.ckRecordID)
        
        // Update user account
        if let user = UserAccountController.sharedController.hostUser {
            let eventHandles = user.eventHandles.flatMap{$0 as? EventHandle}
            let handleToDelete = eventHandles.filter{$0.eventID == event.eventID}
            if let handle = handleToDelete.first {
                user.removeFromEventHandles(handle)
                PersistenceController.sharedController.saveToPersistedStorage()
                let updatedUserRecord = CKRecord(updatedUserWithRecordID: user)
                CloudKitManager.sharedController.modifyRecords([updatedUserRecord], perRecordCompletion: nil, completion: { (records, error) in
                    DispatchQueue.main.async {
                        if error != nil {
                            print("error updating user account event handles")
                        }
                    }
                })
            }
        }
        
        // All children
        let checklists = event.checklists.flatMap{ $0 as? Checklist }
        for checklist in checklists {
            recordIDS.append(checklist.ckRecordID)
            let listItems = checklist.listItems.flatMap{$0 as? ListItem }
            for listItem in listItems {
                recordIDS.append(listItem.ckRecordID)
            }
        }
        
        // Create recordIDs
        for recordID in recordIDS{
            if let recordID = recordID {
                let newrecordID = CKRecordID(recordName: recordID)
                recordsToDelete.append(newrecordID)
            }
        }
        
        for recordToDelete in recordsToDelete {
            CloudKitManager.sharedController.deleteRecordWithID(recordToDelete, completion: { (recordID, error) in
                DispatchQueue.main.async{
                    if error != nil {
                        print("Error deleting. \(error?.localizedDescription)")
                    } else {
                        print("Success deleting: \(recordToDelete.recordName)")
                    }
                }
            })
            
            
        }
        
        
        
        
//        CloudKitManager.sharedController.deleteRecordsWithID(recordsToDelete) { (records, recordIDs, error) in
//            DispatchQueue.main.async {
//                if error != nil {
//                    print("Error deleting event and all children")
//                } else {
//                    print("Success deleting event.")
//                }
//            }
//        }
    }
}
