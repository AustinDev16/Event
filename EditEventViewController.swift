//
//  EditEventViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/11/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EditEventViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    var event: Event?
    
    private let descriptionPlaceHolder: String = "Add a description."
    
    // MARK: - Outlets
    
    @IBOutlet weak var eventNameField: UITextField!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        eventNameField.delegate = self
        eventNameField.returnKeyType = .done
        locationField.delegate = self
        locationField.returnKeyType = .done
        descriptionField.keyboardDismissMode = .interactive
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
            descriptionField.text = self.descriptionPlaceHolder
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
        view.endEditing(true)
        // Conditions for saving and editing
        guard let name = eventNameField.text,
            name.characters.count > 0,
            let location = locationField.text,
            location.characters.count > 0,
            var detailDescription = descriptionField.text else { return }
        
        let date = datePicker.date as NSDate
        
        
        if detailDescription == self.descriptionPlaceHolder {
            detailDescription = ""
        }
        
        if let event = self.event {
            // Update Existing
//            event.name = name
//            event.location = location
//            event.detailDescription = detailDescription
//            event.date = date
            
            EventController.sharedController.modifyEvent(name: name, location: location, detailDescription: detailDescription, date: date, eventToModify: event)
            
        } else {
            // Create new             
            EventController.sharedController.addEvent(name: name, date: date, location: location, detailDescription: detailDescription)
        }
        
        
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    func cancelButtonTapped(){
        view.endEditing(true)
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
