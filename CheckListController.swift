//
//  CheckListController.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CloudKit
import CoreData

class ChecklistController {
    
    // MARK: - public
    static let sharedController = ChecklistController()
    
    
    // MARK: - CloudKit helper
    func findChecklist(forID: String, eventID: String) -> Checklist? {
        guard let event = EventController.sharedController.findEvent(forID: eventID) else { return nil }
        let checklists = event.checklists.flatMap{$0 as? Checklist }
        return  checklists.filter{$0.checklistID == forID}.first
    }
    
    var allListItems: [ListItem] {
        let request: NSFetchRequest<ListItem> = ListItem.fetchRequest()
//        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
//        request.sortDescriptors = [sortDescriptor]
        let moc = CoreDataStack.context
        
        do {
            return try moc.fetch(request)
        } catch {
            return []
        }
        
    }
    // MARK: - Checklist functions
    
    func createNewCheckList(name: String,
                            event: Event){
        
        let newChecklist = Checklist(name: name, event: event)
        event.addToChecklists(newChecklist)
        PersistenceController.sharedController.saveToPersistedStorage()
        
        // CloudKit Saving
        let newRecord = CKRecord(checklist: newChecklist)
        
        CloudKitManager.sharedController.saveRecord(newRecord) { (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error saving new checklist to cloud")
                }
                if let record = record {
                    print ("Success saving checklist to cloud")
                    newChecklist.ckRecordID = record.recordID.recordName
                    PersistenceController.sharedController.saveToPersistedStorage()
                }
            }
        }
    }
    
    func deleteCheckList(checklist: Checklist, event: Event){
        
        CloudKitSyncController.shared.deleteChecklist(checklist: checklist, event: event)
        event.removeFromChecklists(checklist)
        checklist.managedObjectContext?.delete(checklist)
        PersistenceController.sharedController.saveToPersistedStorage()
        
    }
    
    func findChecklistWith(name: String, forEvent: Event) -> Checklist? {
        var foundChecklists: [Checklist] = []
        let castedChecklists = forEvent.checklists.flatMap {$0 as? Checklist}
        for checklist in castedChecklists {
            if checklist.name.lowercased() == name.lowercased() {
                foundChecklists.append(checklist)
            }
        }
        return foundChecklists.first
    }
    
    // MARK: - ListItem functions
    
    func addItemToList(name: String, responsibleParty: String = "none", checklist: Checklist, event: Event){
        
        let newItem = ListItem(name: name, responsibleParty: responsibleParty, checklist: checklist, event: event)
        
        checklist.addToListItems(newItem)
        
        PersistenceController.sharedController.saveToPersistedStorage()
        
        // Save to cloudkit
        let newRecord = CKRecord(listItem: newItem)
        CloudKitManager.sharedController.saveRecord(newRecord) { (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error saving listItem: \(error?.localizedDescription)")
                }
                if let record = record {
                    print("Success saving new list item")
                    newItem.ckRecordID = record.recordID.recordName
                    PersistenceController.sharedController.saveToPersistedStorage()
                }
                
            }
        }
        
        
    }
    
//    func addItemToList(listItem: ListItem, checklist: Checklist){
//    
//        checklist.addToListItems(listItem)
//        
//        PersistenceController.sharedController.saveToPersistedStorage()
//    }
    
    func removeItemFromList(listItem: ListItem, checklist: Checklist){
        
        CloudKitSyncController.shared.deleteListItem(listItem: listItem)
        checklist.removeFromListItems(listItem)
        
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func assignResponsiblePartyToItem(person: Guest, listItem: ListItem){
        // Fill in information here
    }
    
    func removeResponsiblePartyFromItem(listItem: ListItem){
        
    }
    
    func toggleIsDone(listItem: ListItem){
        listItem.isComplete = !listItem.isComplete
        
        PersistenceController.sharedController.saveToPersistedStorage()
        
        // Create Record to Modify
        
        let newRecord = CKRecord(updatedListItemWithRecordID: listItem)
        CloudKitManager.sharedController.modifyRecords([newRecord], perRecordCompletion: nil) { (records, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error modifying checklist: \(error?.localizedDescription)")
                } else {
                    print("Success updating the list item")
                }
                
            }
        }
        
    }
    
    func checklistRecordIDs() -> [CKRecordID] {
        var checklists: [Checklist] = []
        var recordIDs: [CKRecordID] = []
        for event in EventController.sharedController.events{
            let newChecklists = event.checklists.flatMap{ $0 as? Checklist }
            checklists += newChecklists
        }
        for checklist in checklists {
            if let recordIDString = checklist.ckRecordID {
            recordIDs.append(CKRecordID(recordName: recordIDString))
            }
        }
        return recordIDs
    }
    
    func listItemRecordIDs() -> [CKRecordID]{
        var recordIDs: [CKRecordID] = []
        for listItem in ChecklistController.sharedController.allListItems{
            if let recordIDString = listItem.ckRecordID {
                recordIDs.append(CKRecordID(recordName: recordIDString))
            }
        }
        return recordIDs
    }
    

    
    
}
