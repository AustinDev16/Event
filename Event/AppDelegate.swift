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
            print("Event name: \(event.name)")
            print("# of guests: \(event.guests.count)")
            
            for guest in event.guests {
                print((guest as! Guest).userName)
            }
            
            for toDoList in event.checklists {
                let toDoList = toDoList as! Checklist
                print("List name: \(toDoList.name)")
                
                for item in toDoList.listItems {
                    let item = item as! ListItem
                    print("Item: \(item.name)")
                }
            }
        }
        
        //self.modelTests()
        
        return true

        
    }
    
    func modelTests(){
        // create a user
        
        // create an event
        
        EventController.sharedController.addEvent(name: "Event 1")
        
        // create list(s)
        let event = EventController.sharedController.events[1]
        ChecklistController.sharedController.createNewCheckList(name: "To Do", event: event)
        
        ChecklistController.sharedController.createNewCheckList(name: "To Bring", event: event)
        
        // add item(s) to a checklist
        let checklist = event.checklists[0] as! Checklist
        
        let newItem = ListItem(name: "Call caterer", responsibleParty: "Austin", checklist: checklist, event: event)
        ChecklistController.sharedController.addItemToList(listItem: newItem, checklist: checklist)
        
        let newItem2 = ListItem(name: "Mow lawn", responsibleParty: "Austin", checklist: checklist, event: event)
        ChecklistController.sharedController.addItemToList(listItem: newItem2, checklist: checklist)
        
        let newItem3 = ListItem(name: "Pick up dry cleaning", responsibleParty: "Austin", checklist: checklist, event: event)
        ChecklistController.sharedController.addItemToList(listItem: newItem3, checklist: checklist)
        
        
        
        let checklist2 = event.checklists[1] as! Checklist
        
        let newItem4 = ListItem(name: "Potato Salad", responsibleParty: "Austin", checklist: checklist2, event: event)
        ChecklistController.sharedController.addItemToList(listItem: newItem4, checklist: checklist2)
        
        
        // invite others to event
        
        
        
        // complete a task
        
        // reassign a task
        
        // delete event
        
        
        
        // delete checklist
        
        // delete listItem
        
        
        
        
    }




}

