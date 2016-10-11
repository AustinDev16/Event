//
//  EventTableViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/6/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForLoggedInUser()
        
        self.title = "Events"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    // MARK: - User Login 
    func checkForLoggedInUser(){
        if (UserController.sharedController.hasAccount() == false){
            // direct to account page to setup an account
            print("Launching setup account page")
            
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let navigationController = storyboard.instantiateViewController(withIdentifier: "editAccountNavigationController") as? UINavigationController else { return }
            
            
            self.present(navigationController, animated: true, completion: nil)
            
            //  let accountVC = navigationController.viewControllers.first as? EditAccountViewController
        } else {
            // updates from cloud to account
        }

    }

 
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Upcoming events (\(EventController.sharedController.events.count))"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EventController.sharedController.events.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)

        let event = EventController.sharedController.events[indexPath.row]
        
        let date = event.date as Date
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = "\(EventController.dateFormatter.string(from: date))"
        return cell
    }
    

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let eventToDelete = EventController.sharedController.events[indexPath.row]
            EventController.sharedController.deleteEvent(event: eventToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toDetailFromExisting" {
            guard let eventDetailVC = segue.destination as? EventDetailViewController,
            let cell = sender as? UITableViewCell,
            let index = tableView.indexPath(for: cell) else {return}
        
            let selectedEvent = EventController.sharedController.events[index.row]
            
            eventDetailVC.event = selectedEvent
        }
    }
    

}
