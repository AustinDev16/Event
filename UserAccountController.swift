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
        //getLoggedInUserID()
        //getAccountCKRecord()
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
    
    func getLoggedInUserID(completion: @escaping (_ success: Bool) -> Void) {
        CloudKitManager.sharedController.fetchLoggedInUserRecord { (record, error) in
            DispatchQueue.main.async {
                
                if error != nil {
                    print("error fetching logged in user record")
                    completion(false)
                }
                guard let record = record else { return  }
              
                self.iCloudUserID = record.recordID.recordName
                print("getLoggedInUserID() \(record.recordID.recordName) ")
                completion(true)
                
            }
        }
    }
    
    
    func getUserAccountFromCloud(completion: @escaping (_ success: Bool) -> Void) {
        
        UserAccountController.sharedController.getLoggedInUserID { (success) in
            if success {
                
                let userPredicate = NSPredicate(format: "\(User.kCloudKitUserID) == %@", UserAccountController.sharedController.iCloudUserID!)
                CloudKitManager.sharedController.fetchRecordsWithType(User.recordType, predicate: userPredicate,recordFetchedBlock: nil, completion: { (records, error) in
                    
                    DispatchQueue.main.async {
                        if error != nil {
                            print("Could retrieve userAccount from cloud \(error?.localizedDescription)")
                            completion(false)
                        }
                        
                        if let records = records {
                            guard let userRecord = records.first else { completion(false); return }
                            
                            guard let _ = User(record: userRecord) else { completion(false); return }
                            PersistenceController.sharedController.saveToPersistedStorage()
                            
                            completion(true)
                        } else {
                            completion(false)
                        }
                    }
                 })
                
            } else {
                print("Error getting account from cloud because there was no iCloud account.")
                completion(false)
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
                if record != nil {
                    print("Successfully updated account info")
                }
            }
            }, completion: nil)
        
    }
}
