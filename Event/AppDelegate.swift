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
        print(EventController.sharedController.events.count)
        EventController.sharedController.createMockData()
        return true
    }
    
}

