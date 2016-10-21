//
//  eventDetail_DetailViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/7/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit
import EventKitUI

class EventDetail_DetailViewController: UIViewController, EKEventEditViewDelegate {
    // MARK: - Outlets
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hostedByLabel: UILabel!
    
    weak var innerContentViewDelegate: InnerContentViewDelegate?
    
    func editEventButtonTapped(){
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        
//        guard let navigationController = storyboard.instantiateViewController(withIdentifier: "editEventNavigationController") as? UINavigationController,
//        let editVC = navigationController.viewControllers.first as? EditEventViewController else { return }
//        
//        editVC.event = innerContentViewDelegate?.event
//
//        present(navigationController, animated: true, completion: nil)
        
        if CalendarController.shared.hasAccess{
            guard let eventStore = CalendarController.shared.eventStore else { return }
            let editEventVC = EKEventEditViewController()
            editEventVC.eventStore = eventStore
            editEventVC.editViewDelegate = self
            editEventVC.event = innerContentViewDelegate?.event?.fetchedCalRecord()
            self.present(editEventVC, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Edit Event delegate methods
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
        guard let calEvent = controller.event, let eventToModify = innerContentViewDelegate?.event else { return }
        switch action {
        case .canceled:
            break
        case .deleted:
            EventController.sharedController.deleteEvent(event: eventToModify, deletionType: .eventAndCalendar)
            // HANDLE segue back to home view.
            
        case .saved:
            EventController.sharedController.modifyEvent(calEvent: calEvent, eventToModify: eventToModify)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.clear
        updateView()
    }

    func updateView(){
        guard let event = innerContentViewDelegate?.event else { return }
        eventName.text = event.name
       let name = UserAccountController.sharedController.hostUser?.name ?? ""
        hostedByLabel.text = "Hosted by \(name)"
        let date = event.date as Date
        dateLabel.text = EventController.dateFormatter.string(from: date)
        locationLabel.text = "@ \(event.location)"
        descriptionLabel.text = event.detailDescription
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
