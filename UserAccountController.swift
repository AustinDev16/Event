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
        getAccountCKRecord()
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
    
    func hasPersistedAccount() -> Bool {
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
                print("getLoggedInUserID() \(record.recordID.recordName) ")
                
                UserAccountController.sharedController.getAccountCKRecord()
            }
        }
    }
    
    func getAccountCKRecord(){
        
        guard let hostUser = hostUser,
            let ckRecordString = hostUser.ckRecordID else { print("No ckrecordid on hostUser"); return }
        let ckRecordID = CKRecordID(recordName: ckRecordString)
        
        CloudKitManager.sharedController.fetchRecordWithID(ckRecordID) { (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print(" Error getting user record from CloudKit: \(error)")
                }
                if let record = record {
                   print("Successfully fetched accountCKRecord")
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
                PersistenceController.sharedController.saveToPersistedStorage()
            }
        }
    }
    
    func modifyCurrentAccount(user: User, name: String, phoneNumber: String){
        user.name = name
        user.phoneNumber = phoneNumber
        
        let modifiedRecord = CKRecord(updatedUserWithRecordID: user)
        
        PersistenceController.sharedController.saveToPersistedStorage()
        
        // Modify Cloud Kit record
        CloudKitManager.sharedController.modifyRecords([modifiedRecord], perRecordCompletion: { (record, error) in
            DispatchQueue.main.async {
                if error != nil {
                    print("Error modifying the account: \(error?.localizedDescription)")
                    // put the record in the offline queue
                }
                if let record = record {
                    print("Successfully updated account info")
                }
            }
            }, completion: nil)
        
    }
    
    func deleteAccount(){
        
    }
    
    func logoutOfAccount(){
        
    }
}
