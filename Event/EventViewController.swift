//
//  EventTableViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/6/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit
import EventKitUI

extension UITableViewCell {
    func prepareDisclosureIndicator(){
        for case let button as UIButton in subviews {
            let image = button.backgroundImage(for: .normal)?.withRenderingMode(.alwaysTemplate)
            button.setBackgroundImage(image, for: .normal)
            button.tintColor = AppearanceController.purpleColor
        }
    }
}

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, EKEventEditViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        checkForLoggedInUser()
        
        self.title = "Events"
        
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(self.eventsUpdated), name: NSNotification.Name(rawValue: "newEventSaved"), object: nil)
        self.tableView.separatorColor = AppearanceController.purpleColor.withAlphaComponent(0.1)
        self.tableView.separatorStyle = .singleLine
        let view = UIView()
        view.frame = self.tableView.frame
        view.backgroundColor = AppearanceController.whiteColor
        self.tableView.backgroundView = view
        
        
    }
    

    
    func eventsUpdated(){
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        AppearanceController.customizeColors(viewController: self)
        self.tableView.reloadData()
        
        // Readjusts view bottom
        self.tableViewBottomConstraint.isActive = false
        self.tableViewBottomConstraint = NSLayoutConstraint(item: self.tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.tableViewBottomConstraint.isActive = true
        
    }
    
    // MARK: - User Login 
    func checkForLoggedInUser(){
        
        if (UserAccountController.sharedController.hasPersistedAccount() == false){
            
            UserAccountController.sharedController.getUserAccountFromCloud(completion: { (success) in
                if success {
                    // pulled down User account from cloud

                    print("Imported userAccount from iCloud")
                    
                    // Pull events that belong to the user
                    
                    print("Pulling user created events")
                    CloudKitSyncController.shared.getEventsFromUserAccount()
                } else {
                    // direct to account page to setup an account
                    print("Launching setup account page")
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    guard let navigationController = storyboard.instantiateViewController(withIdentifier: "editAccountNavigationController") as? UINavigationController else { return }
                    self.present(navigationController, animated: true, completion: nil)
                    
                    
                }
            })
            //  let accountVC = navigationController.viewControllers.first as? EditAccountViewController
        } else {
            // updates from cloud to account
            //CloudKitSyncController.shared.syncFromServerAnyChanges()
            CloudKitSyncController.shared.performFullSync()
        }
        
    }

 
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerString: String?
        switch section {
        case 0:
            headerString = ("Upcoming events")
        case 1:
            headerString = ("Past events")
        default:
            break
        }
        return headerString
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0:
            return EventController.sharedController.upcomingEvents.count
        case 1:
            return EventController.sharedController.pastEvents.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.prepareDisclosureIndicator()
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        var event: Event?
        switch indexPath.section{
        case 0:
            event = EventController.sharedController.upcomingEvents[indexPath.row]
        case 1:
            event = EventController.sharedController.pastEvents[indexPath.row]
        default:
            break
        }
        guard let eventForCell = event else { return UITableViewCell() }
        
        let date = eventForCell.date as Date
        cell.textLabel?.text = eventForCell.name
        cell.detailTextLabel?.text = "\(EventController.dateFormatter.string(from: date))"
        cell.backgroundColor = UIColor.clear
        return cell
    }
    

    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var eventToDelete: Event?
            switch indexPath.section {
            case 0:
                eventToDelete = EventController.sharedController.upcomingEvents[indexPath.row]
            case 1:
                eventToDelete = EventController.sharedController.pastEvents[indexPath.row]
            default:
                break
            }
            
            let deleteAction = UIAlertController(title: nil, message: "Events are synced to your calendar. Do you want to remove this event from your calendar?", preferredStyle: .actionSheet)
            let calendarAction = UIAlertAction(title: "Remove calendar event", style: .destructive, handler: { (_) in
                if let eventToDelete = eventToDelete{
                EventController.sharedController.deleteEvent(event: eventToDelete, deletionType: .eventAndCalendar)
                tableView.deleteRows(at: [indexPath], with: .fade)
                }
            })
            
            let eventAction = UIAlertAction(title: "Remove from app only", style: .destructive, handler: { (_) in
                if let eventToDelete = eventToDelete{
                EventController.sharedController.deleteEvent(event: eventToDelete, deletionType: .eventOnly)
                tableView.deleteRows(at: [indexPath], with: .fade)
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
                
                self.tableView.setEditing(false, animated: true)
            })
            
            deleteAction.addAction(calendarAction)
            deleteAction.addAction(eventAction)
            deleteAction.addAction(cancelAction)
            
            
            self.present(deleteAction, animated: true, completion: nil)
            
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
    
    @IBAction func newEventTapped(_ sender: AnyObject) {
        if CalendarController.shared.hasAccess {
            guard let eventStore = CalendarController.shared.eventStore else { return }
            let tempEvent = EKEvent(eventStore: eventStore)
            let newEventVC = EKEventEditViewController()
            newEventVC.eventStore = eventStore
            tempEvent.calendar = eventStore.defaultCalendarForNewEvents
            newEventVC.event = tempEvent
            newEventVC.editViewDelegate = self
            self.present(newEventVC, animated: true, completion: nil)
        }
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        guard let calEvent = controller.event else { return }
        switch action {
        case .canceled:
            break
        case .deleted:break
            // fill in 
        case .saved:
            // Create event to match
            EventController.sharedController.addEvent(calEvent: calEvent)
        }
        controller.dismiss(animated: true, completion: nil)
        
    }
    
 
    

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "toDetailFromExisting" {
            guard let eventDetailVC = segue.destination as? EventDetailViewController,
            let cell = sender as? UITableViewCell,
            let index = tableView.indexPath(for: cell) else {return}
            var events: [Event] = []
            switch index.section{
            case 0:
                events = EventController.sharedController.upcomingEvents
            case 1:
                events = EventController.sharedController.pastEvents
            default:
                events = []
            }
        
            let selectedEvent = events[index.row]
            
            eventDetailVC.event = selectedEvent
        }
    }
    

}
