//
//  EditEventViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/11/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController {
    var event: Event?
    
    // MARK: - Outlets
    
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupNavigationBar()
        updateView()
    }
    
    func updateView(){
        if let event = self.event {
            self.title = "Edit Event"
            eventNameField.text = event.name
            locationField.text = event.location
            descriptionField.text = event.detailDescription
            datePicker.date = event.date as Date
        } else {
            self.title = "New Event"
        }
    }
    
    func setupNavigationBar(){
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,target: self, action: #selector(cancelButtonTapped))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doneButtonTapped))
        
        self.title = "Edit Event"
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func doneButtonTapped(){
        
        if let event = self.event {
            // Update Existing
        } else {
            // Create new
            
            
        }
        
        
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    func cancelButtonTapped(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
