//
//  UserController.swift
//  Event
//
//  Created by Austin Blaser on 10/11/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CloudKit

class UserAccountController {
    static let sharedController = UserAccountController()
    
    init(){
        getLoggedInUserID()
        getAccountRecord()
    }
    
    
    var hostUser: User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let moc = CoreDataStack.context
        var fetchedUser: [User]
        do {
            fetchedUser = try moc.fetch(request)
        } catch {
            fetchedUser = []
        }
        
        guard let user = fetchedUser.first else { return nil }
        return user
    }
    
    func hasAccount() -> Bool {
        return self.hostUser != nil
    }
    
    var iCloudUserID: String?
    
    func getLoggedInUserID() {
        CloudKitManager.sharedController.fetchLoggedInUserRecord { (record, error) in
            DispatchQueue.main.async {
                
                if error != nil {
                    print("error fetching logged in user record")
                }
                guard let record = record else { return  }
              
                self.iCloudUserID = record.recordID.recordName
            }
        }
    }
    
    func getAccountRecord(){
        
        guard let hostUser = hostUser,
        let ckRecordString = hostUser.ckRecordID else { return }
        let ckRecordID = CKRecordID(recordName: ckRecordString)
        
        CloudKitManager.sharedController.fetchRecordWithID(ckRecordID) { (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print(" Error getting user record from CloudKit: \(error)")
                }
                if let record = record {
                    hostUser.ckRecord = record
                }
            }
        }
    }
    
    func createNewAccount(name: String, phoneNumber: String){
        
        guard let iCloudUserID = self.iCloudUserID else { print("No icloud user id...yet"); return}

        let newUser = User(name: name, phoneNumber: phoneNumber, cloudKitUserID: iCloudUserID)
        
        
        
        // Create/Save CloudKit Record
        let record = CKRecord(user: newUser)
        
        CloudKitManager.sharedController.saveRecord(record) { (record, error) in
            
            DispatchQueue.main.async {
                if error != nil {
                    print("Error saving account record to the cloud")
                }
                guard let record = record else { return }
                newUser.ckRecordID = record.recordID.recordName
                newUser.ckRecord = record
                PersistenceController.sharedController.saveToPersistedStorage()
            }
        }
    }
    
    func modifyCurrentAccount(user: User, name: String, phoneNumber: String){
        user.name = name
        user.phoneNumber = phoneNumber
        
        guard let record = user.ckRecord else { return }
        record["displayName"] = user.name as CKRecordValue?
        record["phoneNumber"] = user.phoneNumber as CKRecordValue?
        
        user.ckRecord = nil
        PersistenceController.sharedController.saveToPersistedStorage()
        
        // Modify Cloud Kit record
        CloudKitManager.sharedController.modifyRecords([record], perRecordCompletion: { (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error modifying the account: \(error?.localizedDescription)")
                }
                if let record = record {
                    user.ckRecord = record
                    PersistenceController.sharedController.saveToPersistedStorage()
                }
            }
            }, completion: nil)
        
    }
    
    func deleteAccount(){
        
    }
    
    func logoutOfAccount(){
        
    }
}
