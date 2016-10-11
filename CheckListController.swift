//
//  CheckListController.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation

class ChecklistController {
    
    // MARK: - public
    static let sharedController = ChecklistController()
    
    
    // MARK: - Checklist functions
    
    func createNewCheckList(name: String,
                            event: Event){
        
        let newChecklist = Checklist(name: name, event: event)
        event.addToChecklists(newChecklist)
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func deleteCheckList(checklist: Checklist, event: Event){
        
        event.removeFromChecklists(checklist)
        checklist.managedObjectContext?.delete(checklist)
        PersistenceController.sharedController.saveToPersistedStorage()
        
    }
    
    // MARK: - ListItem functions
    
    func addItemToList(name: String, responsibleParty: String = "Austin", checklist: Checklist, event: Event){
        
        let newItem = ListItem(name: name, responsibleParty: responsibleParty, checklist: checklist, event: event)
        
        checklist.addToListItems(newItem)
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func addItemToList(listItem: ListItem, checklist: Checklist){
    
        checklist.addToListItems(listItem)
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
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
