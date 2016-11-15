//
//  CalendarViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/20/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit
import EventKitUI

class CalendarViewController: EKEventViewController, EKEventEditViewDelegate {
    weak var innerContentViewDelegate: InnerContentViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.navigationController?.toolbar.isHidden = true
        self.navigationController?.toolbar.removeFromSuperview()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func editEventBarButtonTapped(){
        if CalendarController.shared.hasAccess{
            guard let eventStore = CalendarController.shared.eventStore else { return }
            let editEventVC = EKEventEditViewController()
            editEventVC.eventStore = eventStore
            editEventVC.editViewDelegate = self
            editEventVC.event = innerContentViewDelegate?.event?.fetchedCalRecord()
            self.present(editEventVC, animated: true, completion: nil)
        }
        
    }
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        guard let calEvent = controller.event else { return }
        switch action {
        case .canceled:
            break
        case .deleted:
            if let event = innerContentViewDelegate?.event {
                EventController.sharedController.deleteEvent(event: event, deletionType: .eventOnly)
                innerContentViewDelegate?.event = nil
            }
        case .saved:
            // Modify existing event
            if let event = innerContentViewDelegate?.event {
            EventController.sharedController.modifyEvent(calEvent: calEvent, eventToModify: event)
            }
        }
        controller.dismiss(animated: true, completion: nil)
        
    }

    func updateWithEvent(event: Event){
        guard let calEvent = event.fetchedCalRecord() else { return }
        self.event = calEvent
        self.allowsEditing = false
        self.allowsCalendarPreview = true
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
