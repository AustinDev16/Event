//
//  DiscoverableUser.swift
//  Event
//
//  Created by Austin Blaser on 10/12/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
class DiscoverableUser {
    let userName: String
    let userID: String
    let phoneNumber: String
    
    init(userName: String, userID: String, phoneNumber: String){
        self.userName = userName
        self.userID = userID
        self.phoneNumber = phoneNumber
    }
    
}

extension DiscoverableUser: Equatable {
    static func == (lhs: DiscoverableUser, rhs: DiscoverableUser) -> Bool {
        return lhs.userName == rhs.userName && lhs.userID == rhs.userID && lhs.phoneNumber == rhs.phoneNumber
    }
}
