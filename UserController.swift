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

class UserController {
    static let sharedController = UserController()
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
    
    func createNewAccount(){
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        guard let navigationController = storyboard.instantiateViewController(withIdentifier: "editAccountNavigationController") as? UINavigationController else { return }
//        
//        .rootViewController?.present(navigationController, animated: true, completion: nil)
//        
//        //  let accountVC = navigationController.viewControllers.first as? EditAccountViewController
        
        
        
        
        
    }
    
    func modifyCurrentAccount(){
        
    }
    
    func deleteAccount(){
        
    }
    
    func logoutOfAccount(){
        
    }
}
