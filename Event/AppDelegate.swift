//
//  AppDelegate.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print("Has active account: \(UserController.sharedController.hasAccount())")
        
        checkForLoggedInUser()
        // Override point for customization after application launch.
        
        print(EventController.sharedController.events.count)
        
        EventController.sharedController.createMockData()
        
//        print(EventController.sharedController.events.count)
//        
//        for event in EventController.sharedController.events {
//            print("Event name: \(event.name)")
//            print("# of guests: \(event.guests.count)")
//            
//            for guest in event.guests {
//                print((guest as! Guest).userName)
//            }
//            
//            for toDoList in event.checklists {
//                let toDoList = toDoList as! Checklist
//                print("List name: \(toDoList.name)")
//                
//                for item in toDoList.listItems {
//                    let item = item as! ListItem
//                    print("Item: \(item.name)")
//                }
//            }
//        }
//        
        //self.modelTests()
        
        return true

        
    }
    
    func checkForLoggedInUser(){
        if (UserController.sharedController.hasAccount() == false){
            // direct to account page to setup an account
            print("Launching setup account page")
        } else {
            // updates from cloud to account
        }
    }
    



}

