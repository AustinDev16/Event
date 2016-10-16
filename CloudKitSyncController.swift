
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
    
    func deleteListItem(listItem: ListItem){
        guard let recordName = listItem.ckRecordID else { return }
        let newRecordID = CKRecordID(recordName: recordName)
        CloudKitManager.sharedController.deleteRecordWithID(newRecordID) { (recordID, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error deleting list item: \(error?.localizedDescription)")
                } else {
                    print("Success deleting \(recordID?.recordName)")
                }
            }
        }
    }
    
    func deleteChecklist(checklist: Checklist, event: Event){
        var recordsToDelete: [CKRecordID]  = []
        var recordIDS: [String?] = []
        recordIDS.append(checklist.ckRecordID)
        
        let listItems = checklist.listItems.flatMap{ $0 as? ListItem }
        for listItem in listItems {
            recordIDS.append(listItem.ckRecordID)
        }
        
        for recordID in recordIDS {
            if let recordID = recordID {
                let newRecordID = CKRecordID(recordName: recordID)
                recordsToDelete.append(newRecordID)
            }
        }
        
        for record in recordsToDelete{
            CloudKitManager.sharedController.deleteRecordWithID(record, completion: { (recordID, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        print("Error deleting records \(error?.localizedDescription)")
                    } else {
                        print("Success deleting \(recordID?.recordName)")
                    }
                }
            })
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
    }
    
    func performFullSync(){
        CloudKitSyncController.shared.performEventLevelSync { (success) in
            if success {
                // get recordIds for all Checklists and list items
                
                let checklistIDs = ChecklistController.sharedController.checklistRecordIDs()
                var checklistReferences: [CKReference] = []
                for ID in checklistIDs{
                    let record = CKRecord(recordType: Checklist.recordType, recordID: ID)
                    let reference = CKReference(record: record, action: .none)
                    checklistReferences.append(reference)
                }
                let predicate = NSPredicate(format: "NOT(recordID IN %@)", checklistReferences)
                CloudKitManager.sharedController.fetchRecordsWithType(Checklist.recordType, predicate: predicate, recordFetchedBlock: nil, completion: { (records, error) in
                    DispatchQueue.main.async {
                        if error != nil {
                            print("error fetching new checklists")
                        }
                        if let records = records{
                            for record in records {
                                let _ = Checklist(record: record)
                                PersistenceController.sharedController.saveToPersistedStorage()
                                let notification = Notification(name: Notification.Name(rawValue: "newChecklistSaved"))
                                NotificationCenter.default.post(notification)
                            }
                            
                        }
                        // Go get the list items
                            let listItemIDs = ChecklistController.sharedController.listItemRecordIDs()
                            var listItemReferences: [CKReference] = []
                            for ID in listItemIDs {
                                let record = CKRecord(recordType: ListItem.recordType, recordID: ID)
                                let reference = CKReference(record: record, action: .none)
                                listItemReferences.append(reference)
                            }
                            let predicate = NSPredicate(format: "NOT(recordID IN %@)", listItemReferences)
                            CloudKitManager.sharedController.fetchRecordsWithType(ListItem.recordType, predicate: predicate, recordFetchedBlock: nil, completion: { (records, error) in
                                DispatchQueue.main.async {
                                    if error != nil {
                                        print("Error getting new list items: \(error?.localizedDescription)")
                                    }
                                    if let records = records{
                                        for record in records{
                                            let _ = ListItem(record: record)
                                            PersistenceController.sharedController.saveToPersistedStorage()
                                            let notification = Notification(name: Notification.Name(rawValue: "newListItemSaved"))
                                            NotificationCenter.default.post(notification)
                                        }
                                    }
                                }//end dispatch of listitems
                            })
                        
                        //}
                    } // end dispatch of Checklists
                })
            } else {
                print("Error")
            }
        }
        
    }
    
    
    
    func performEventLevelSync(completion: @escaping (Bool) -> Void){
        
        CloudKitSyncController.shared.fetchNewUserAccountRecord { (success) in
            if success {
                // Check which events are saved and which ones need to be deleted
                guard let user = UserAccountController.sharedController.hostUser else { return }
                let eventHandles = user.eventHandles.flatMap{$0 as? EventHandle }
                var eventsToKeep: [Event] = []
                for event in EventController.sharedController.events{
                    for eventHandle in eventHandles{
                        if event.eventID == eventHandle.eventID {
                            eventsToKeep.append(event)
                        }
                    }
                }
                let eventsToDelete = EventController.sharedController.events.filter{!eventsToKeep.contains($0)}
                for eventToDelete in eventsToDelete {
                    EventController.sharedController.deleteEvent(event: eventToDelete)
                }
                var eventIDsToDownload: [String] = []
                for eventHandle in eventHandles{
                    if !EventController.sharedController.eventIDs.contains(eventHandle.eventID) {
                       eventIDsToDownload.append(eventHandle.eventID)
                    }
                }
                // Download records
                for eventID in eventIDsToDownload{
                    let predicate = NSPredicate(format: "eventID == %@", eventID)
                CloudKitManager.sharedController.fetchRecordsWithType(Event.recordType, predicate: predicate, recordFetchedBlock: nil, completion: { (records, error) in
                    DispatchQueue.main.async {
                        if error != nil {
                            print("Error fetching new events \(error?.localizedDescription)")
                            completion(false)
                        }
                        if let records = records {
                            for record in records {
                                if let newEvent = Event(record: record) {
                                    PersistenceController.sharedController.saveToPersistedStorage()
                                    let notification = Notification(name: NSNotification.Name(rawValue: "newEventSaved"), object: nil)
                                    NotificationCenter.default.post(notification)
                                    //CloudKitSyncController.shared.getChecklists(forEvent: newEvent)
                                }
                            }
                        }
                    }
                })
             
                }
                completion(true)
            } else {
                completion(false)
            }
        }
       
        
    }
    
    func fetchNewUserAccountRecord(completion: @escaping (Bool) -> Void){
        // Update userAccount
        guard let user = UserAccountController.sharedController.hostUser,
            let recordIDString = user.ckRecordID else { return }
        let userRecordID = CKRecordID(recordName: recordIDString)
        CloudKitManager.sharedController.fetchRecordWithID(userRecordID) { (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error fetching userAccount record")
                    completion(false)
                }
                if let record = record {
                    
                    guard let updatedUser = User(record: record) else { return }
                    UserAccountController.sharedController.updateCurrentAccountFromSync(updatedUser: updatedUser)
                    completion(true)
                }
            }
        }
    }
}
