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


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AppearanceController.colorNavigationBar()
        print(EventController.sharedController.events.count)
        EventController.sharedController.createMockData()
        let locMan = CLLocationManager()
       locMan.requestWhenInUseAuthorization()
        
        CalendarController.shared.setUpEventStore()
        CalendarController.shared.eventStore?.requestAccess(to: .event, completion: { (granted, error) in
            
        })
        return true
    }
    
}

