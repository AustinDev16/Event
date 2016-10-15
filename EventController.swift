//
//  EventController.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData
import CloudKit

class EventController {
    
    func createMockData(){
        
        if events.count ==  0 {
            
//            EventController.sharedController.addEvent(name: "Picnic")
//            let selectedEvent = EventController.sharedController.events[0]
//            EventController.sharedController.addGuest(userName: "Bill", event: selectedEvent)
//
            
        }
        
        
    }
    
    // MARK: - Public properties
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }()
    

    // MARK: - Public functions
    static let sharedController = EventController()
    
    // MARK: - Properties

    
    var events: [Event] {
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        let moc = CoreDataStack.context
        
        do {
            return try moc.fetch(request)
        } catch {
            return []
        }
        
    }
    
    // MARK: - CLoudKitHelper Functions
    
    func generateHostUsersEventHandlesArray() -> [String] {
        guard let user = UserAccountController.sharedController.hostUser else { return [] }
        
        var eventHandlesArray: [String] = []
        for eventHandle in user.eventHandles {
            guard let handle = eventHandle as? EventHandle else { return [] }
            let eventID = handle.eventID
            let eventType = handle.eventType
            eventHandlesArray.append("\(eventID)$\(eventType)")
        }
        return eventHandlesArray
    }
    
    func findEvent(forID: String) -> Event? {
        let dictionary = UserAccountController.sharedController.eventIDDictionary
        
        return dictionary[forID] ?? nil

    }
    // MARK: - private Functions
    
    func addEvent(name: String, date: NSDate, location: String, detailDescription: String){
        let newEvent = Event(name: name, date: date, location: location, detailDescription: detailDescription)
        
        UserAccountController.sharedController.addEventToUser(event: newEvent)
                
        PersistenceController.sharedController.saveToPersistedStorage()
        
        // Save new event to cloud
        let newRecord = CKRecord(event: newEvent)
        CloudKitManager.sharedController.saveRecord(newRecord) { (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print ("Error saving new event to cloud")
                }
                if let record = record {
                    newEvent.ckRecordID = record.recordID.recordName
                }
            }
        }
    }
    
    func addGuest(newGuest: DiscoverableUser,
                  event: Event){
        let userName = newGuest.userName
        
        let newGuest = Guest(userName: userName, eventID: event.eventID, event: event)
        event.addToGuests(newGuest)
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func removeGuest(guest: Guest, event: Event){
        
        event.removeFromGuests(guest)
        guest.managedObjectContext?.delete(guest)
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func deleteEvent(event: Event){
        
        CloudKitSyncController.shared.deleteEvent(event: event)
        event.managedObjectContext?.delete(event)
        PersistenceController.sharedController.saveToPersistedStorage()
        
    }
    
    func eventHasBeenModified(){
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    

}
