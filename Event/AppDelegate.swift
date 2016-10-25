//
//  AppDelegate.swift
//  Event
//
//  Created by Austin Blaser on 10/5/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit
import CloudKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sharedStore: CalendarController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        self.sharedStore = CalendarController.shared
        
        AppearanceController.colorNavigationBar()
        print(EventController.sharedController.events.count)
        EventController.sharedController.createMockData()
        
        CalendarController.shared.locManager.requestWhenInUseAuthorization()
        
        CalendarController.shared.setUpEventStore()
        CalendarController.shared.eventStore?.requestAccess(to: .event, completion: { (granted, error) in
            
        })
        
        return true
    }
    
}

