//
//  EventDetailTableViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/6/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EventDetailTableViewController: UITableViewController {
    //MARK: - Properties
    
    var event: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let event = event {
            self.title = event.name
            
            print(event.checklists.count)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Actions
    
    @IBAction func addListTapped(_ sender: AnyObject) {
        let addListAlertController = UIAlertController(title: "Add a new list", message: nil, preferredStyle: .alert)
        addListAlertController.addTextField { (textfield) in
            textfield.placeholder = "Title of new list"
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let add = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let event = self.event,
                let textField = addListAlertController.textFields?.first,
                let text = textField.text,
                text.characters.count > 0 else {return}
            
            textField.resignFirstResponder()
            
            ChecklistController.sharedController.createNewCheckList(name: text, event: event)
            
            self.tableView.reloadData()
        }
        
        addListAlertController.addAction(cancel)
        addListAlertController.addAction(add)
        
        self.present(addListAlertController, animated: true, completion: nil)
        
    }
    
    @IBAction func addListItemTapped(_ sender: AnyObject) {
        
        
    }
    
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let checklist = event?.checklists[section] as? Checklist else {return nil}
        return checklist.name
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return event?.checklists.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        guard let checklist = event?.checklists[section] as? Checklist else { return 0}
        return checklist.listItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath) as? ListItemTableViewCell
        let checklist = event?.checklists[indexPath.section] as? Checklist
        let listItem = checklist?.listItems[indexPath.row] as? ListItem
        
        cell?.textLabel?.text = listItem?.name
        // Configure the cell...
        
        return cell ?? UITableViewCell()
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
        if segue.identifier == "toAddListItem" {
            guard let newViewController = segue.destination as? AddListItemViewController else {return}
            
            newViewController.event = self.event
        }
     }
 
    
}
