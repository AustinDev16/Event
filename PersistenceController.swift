//
//  PersistenceController.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import CoreData

class PersistenceController {
    
    // MARK: - Public
    static let sharedController = PersistenceController()
    
    
    
    // MARK: - Sync Controller
    
    func saveToPersistedStorage(){
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving to persisted storage: \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - CloudKit Functions
    
    
    
}
