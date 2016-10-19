//
//  AppDelegate.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print(EventController.sharedController.events.count)
        EventController.sharedController.createMockData()
        
        CalendarController.shared.setUpEventStore()
        CalendarController.shared.eventStore?.requestAccess(to: .event, completion: { (granted, error) in
            
        })
        return true
    }
    
}

