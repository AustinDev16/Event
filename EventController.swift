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
//    let request: NSFetchRequest<Event> = Event.fetchRequest()
//    let moc = CoreDataStack.context
//    
//    do {
//    return try moc.fetch(request)
//    } catch {
//    return []
//    }
    
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
    
    // private Functions
    
    func addEvent(name: String, date: NSDate, location: String, detailDescription: String){
        let _ = Event(name: name, date: date, location: location, detailDescription: detailDescription)
       
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func addGuest(newGuest: DiscoverableUser,
                  event: Event){
        let userName = newGuest.userName
        
        let newGuest = Guest(userName: userName, eventID: event.eventID, event: event)
        event.addToGuests(newGuest)
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func unInviteGuest(guest: Guest, event: Event){
        
        event.removeFromGuests(guest)
        guest.managedObjectContext?.delete(guest)
        
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    
    func deleteEvent(event: Event){
        event.managedObjectContext?.delete(event)
        PersistenceController.sharedController.saveToPersistedStorage()
        
    }
    
    func eventHasBeenModified(){
        PersistenceController.sharedController.saveToPersistedStorage()
    }
    

}
