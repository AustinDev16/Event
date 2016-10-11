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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,target: self, action: #selector(cancelButtonTapped))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        self.title = "Edit Event"
        
        self.navigationItem.leftBarButtonItem = cancelButton
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func doneButtonTapped(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    func cancelButtonTapped(){
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
}
