//
//  CalendarHelper.swift
//  Event
//
//  Created by Austin Blaser on 10/19/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import EventKit

extension Event {
    convenience init(calEvent: EKEvent){
        let name = calEvent.title ?? ""
        let date = calEvent.startDate as NSDate
        let location = calEvent.location ?? ""
        let detailDescription = calEvent.notes ?? ""
        self.init(name: name, date: date, location: location, detailDescription: detailDescription)
        self.calEventID = calEvent.eventIdentifier
    }
    
    
    func fetchedCalRecord() -> EKEvent? {
        guard let eventStore = CalendarController.shared.eventStore,
        let calRecordID = self.calEventID else { return nil }
        return eventStore.event(withIdentifier: calRecordID)
    }
}


