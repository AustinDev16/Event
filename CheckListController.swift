//
//  CheckListController.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CloudKit

class ChecklistController {
    
    // MARK: - public
    static let sharedController = ChecklistController()
    
    // MARK: - CloudKit helper
    func findChecklist(forID: String, eventID: String) -> Checklist? {
        guard let event = EventController.sharedController.findEvent(forID: eventID) else { return nil }
        let checklists = event.checklists.flatMap{$0 as? Checklist }
        return  checklists.filter{$0.checklistID == forID}.first
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
        
        event.removeFromChecklists(checklist)
        checklist.managedObjectContext?.delete(checklist)
        PersistenceController.sharedController.saveToPersistedStorage()
        
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
    }
    

    
    
}
