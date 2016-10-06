//
//  EventTableViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/6/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EventTableViewController: UITableViewController {

    @IBAction func newEventTapped(_ sender: AnyObject) {
        
        let addEventAlertController = UIAlertController(title: "Event", message: "Fill out event details", preferredStyle: .alert)
        
        addEventAlertController.addTextField { (textField) in
            textField.placeholder = "Event name"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let add = UIAlertAction(title: "Create event", style: .default) { (_) in
            
            
            guard let textField = addEventAlertController.textFields?.first,
               let nameText = textField.text,
            nameText.characters.count > 0 else { return }
            textField.resignFirstResponder()
            EventController.sharedController.addEvent(name: nameText)
            
            self.tableView.reloadData()
        }
        
        
        addEventAlertController.addAction(cancel)
        addEventAlertController.addAction(add)
        
        self.present(addEventAlertController, animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

 
    // MARK: - Table view data source

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EventController.sharedController.events.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)

        let event = EventController.sharedController.events[indexPath.row]
        
        cell.textLabel?.text = event.name
        cell.detailTextLabel?.text = "\(event.detailDescription) \(event.date)"
        return cell
    }
    


    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
            guard let eventDetailTVC = segue.destination as? EventDetailTableViewController,
            let cell = sender as? UITableViewCell,
            let index = tableView.indexPath(for: cell) else {return}
        
            let selectedEvent = EventController.sharedController.events[index.row]
            
            eventDetailTVC.event = selectedEvent
        }
    }
    

}
