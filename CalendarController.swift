//
//  CalendarController.swift
//  Event
//
//  Created by Austin Blaser on 10/19/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import EventKit

class CalendarController {
    static let shared = CalendarController()
    
    var eventStore: EKEventStore {
        return EKEventStore()
    }
   
    var hasAccess: Bool {
        var success: Bool = false
        self.eventStore.requestAccess(to: .event) { (access, error) in
            if error != nil {
                print("Error requesting access: \(error?.localizedDescription)")
            }
            success = access
        }
        return success
    }
    
    func saveCalendarEvent(){
        
    }
    
    func deleteCalendarEvent(forEvent event: Event){
        if self.hasAccess{
            guard let calEventID = event.calEventID,
            let calEventToDelete = self.eventStore.event(withIdentifier: calEventID)  else { return }
            do {
                try self.eventStore.remove(calEventToDelete, span: .thisEvent, commit: true)
            } catch {
                print("Error deleting event")
            }
            
        }
    }
    
}
