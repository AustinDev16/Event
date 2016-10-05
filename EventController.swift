//
//  EventController.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

class EventController {
    
    func createMockData(){
        
        if events.count ==  0 {
            
            EventController.sharedController.addEvent(name: "Picnic")
            let selectedEvent = EventController.sharedController.events[0]
            EventController.sharedController.addGuest(userName: "Bill", event: selectedEvent)
            
            
            
        }
        
        
    }
    // MARK: - Public functions
    static let sharedController = EventController()
    
    // MARK: - Properties
    
    var events: [Event] {
        let request: NSFetchRequest<Event> = Event.fetchRequest()
        let moc = CoreDataStack.context
        
        do {
            return try moc.fetch(request)
        } catch {
            return []
        }
    }
    
    // private Functions
    
    func addEvent(name: String){
        let _ = Event(name: name)
       
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func addGuest(userName: String,
                  event: Event){
        
        
        let newGuest = Guest(userName: userName, eventID: event.eventID, event: event)
        event.addToGuests(newGuest)
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func deleteEvent(){
        
    }
    
    func modifyEvent(){
        
    }
    

}
