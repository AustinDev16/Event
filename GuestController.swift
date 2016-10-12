//
//  GuestController.swift
//  Event
//
//  Created by Austin Blaser on 10/12/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
class GuestController {
    static var guestsInCloud: [DiscoverableUser] {
        let a = DiscoverableUser(userName: "Emily Robison", userID: "1", phoneNumber: "2890")
        let b = DiscoverableUser(userName: "Liz Blaser", userID: "2", phoneNumber: "6354")
        let c = DiscoverableUser(userName: "Shaun Blaser", userID: "3", phoneNumber: "8345")
        let d = DiscoverableUser(userName: "Matthew Blaser", userID: "4", phoneNumber: "8225")
        
        return [a, b, c, d]
    }
    
    static func searchForGuest(name: String) -> [DiscoverableUser]{
        let filteredGuests = GuestController.guestsInCloud.filter {
        $0.userName.lowercased().contains(name.lowercased())
        }
        
        return filteredGuests
    }
}
