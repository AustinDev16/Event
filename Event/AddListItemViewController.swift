//
//  AddListItemViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/6/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class AddListItemViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var event: Event?
    
    // MARK: - Outlets
    
    @IBOutlet weak var listItemTextField: UITextField!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryPicker.delegate = self
        
        // Do any additional setup after loading the view.
    }

    // MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: AnyObject) {
        
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButtonTapped(_ sender: AnyObject) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Picker Delegate Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let event = self.event else {return 0}
        return event.checklists.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let checklists = self.event?.checklists,
        let checklist = checklists[row] as? Checklist else { return ""}
        return checklist.name
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
