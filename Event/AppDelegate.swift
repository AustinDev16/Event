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
        // Override point for customization after application launch.
        
        print(EventController.sharedController.events.count)
        
        EventController.sharedController.createMockData()
        
        print(EventController.sharedController.events.count)
        
        for event in EventController.sharedController.events {
            print("# of guests: \(event.guests.count)")
            for guest in event.guests {
                print((guest as! Guest).userName)
            }
        }
        
        
        return true

        
    }




}

