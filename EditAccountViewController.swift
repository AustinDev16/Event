//
//  EditAccountViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/11/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EditAccountViewController: UIViewController, UITextFieldDelegate {
    
    var user: User?
    let instructionLabel = UILabel()
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let phoneNumberLabel = UILabel()
    let phoneNumberTextField = UITextField()
    
    func addUIElementsToView(){
        // Instruction Label
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        instructionLabel.numberOfLines = 0
        instructionLabel.textAlignment = .justified
        instructionLabel.text = "An account lets you invite friends to events and keep all your iOS devices up to date."
        self.view.addSubview(instructionLabel)
        
        let instructionLabelTop = NSLayoutConstraint(item: instructionLabel, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 8)
        let instructionLabelLeading = NSLayoutConstraint(item: instructionLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0)
        let instructionLabelTrailing = NSLayoutConstraint(item: instructionLabel, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([instructionLabelTop, instructionLabelLeading, instructionLabelTrailing])
        
        // Name Label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Choose a display name:"
        nameLabel.numberOfLines = 0
        self.view.addSubview(nameLabel)
        
        let nameLabelTop = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: instructionLabel, attribute: .bottom, multiplier: 1.0, constant: 16.0)
        let nameLabelLeading = NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let nameLabelTrailing = NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        self.view.addConstraints([nameLabelTop, nameLabelLeading, nameLabelTrailing])
        
        // name text field
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.placeholder = "Screen name"
        nameTextField.keyboardAppearance = .dark
        nameTextField.borderStyle = .roundedRect
        nameTextField.returnKeyType = .done
        nameTextField.textAlignment = .center
        nameTextField.delegate = self
        self.view.addSubview(nameTextField)
        
        let nameTFTop = NSLayoutConstraint(item: nameTextField, attribute: .top, relatedBy: .equal, toItem: nameLabel, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let nameTFLeading = NSLayoutConstraint(item: nameTextField, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let nameTFTrailing = NSLayoutConstraint(item: nameTextField, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        self.view.addConstraints([nameTFTop, nameTFLeading, nameTFTrailing])
        
        // phone label
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.text = "Add your phone number:"
        phoneNumberLabel.numberOfLines = 0
        self.view.addSubview(phoneNumberLabel)
        
        let phoneLabelTop = NSLayoutConstraint(item: phoneNumberLabel, attribute: .top, relatedBy: .equal, toItem: nameTextField, attribute: .bottom, multiplier: 1.0, constant: 16.0)
        let phoneLabelLeading = NSLayoutConstraint(item: phoneNumberLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0)
        let phoneLabelTrailing = NSLayoutConstraint(item: phoneNumberLabel, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        self.view.addConstraints([phoneLabelTop, phoneLabelLeading, phoneLabelTrailing])
        
        //phone number field
        phoneNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberTextField.placeholder = "Tap to add number"
        phoneNumberTextField.keyboardType = .numberPad
        phoneNumberTextField.returnKeyType = .done
        phoneNumberTextField.delegate = self
        phoneNumberTextField.keyboardAppearance = .dark
        phoneNumberTextField.textAlignment = .center
        self.view.addSubview(phoneNumberTextField)
        
        let phoneNumberTFTop = NSLayoutConstraint(item: phoneNumberTextField, attribute: .top, relatedBy: .equal, toItem: phoneNumberLabel, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let phoneNumberTFLeading = NSLayoutConstraint(item: phoneNumberTextField, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0)
        let phoneNumberTFTrailing = NSLayoutConstraint(item: phoneNumberTextField, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        self.view.addConstraints([phoneNumberTFTop, phoneNumberTFLeading, phoneNumberTFTrailing])
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItems()
        setupViews()
        addUIElementsToView()
    }
    
    func setupViews(){
        if let user = self.user {
            self.title = "Edit Account"
            nameTextField.text = user.name
            phoneNumberTextField.text = String(user.phoneNumber)
        } else {
            self.title = "New Account"
        }
    }
    
    // MARK: - TextField Delegate methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - NavigationBar
    func setupNavigationBarItems(){
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(createNewAccount))
        self.navigationItem.rightBarButtonItem = done
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewAccountTapped))
        self.navigationItem.leftBarButtonItem = cancel
    }
    
    @objc func createNewAccount(){
        view.endEditing(true)
        guard let name = nameTextField.text,
            let phoneNumber = phoneNumberTextField.text else {return}
        
        if name.count == 0 || phoneNumber.count != 10 {
            let characterAlert = UIAlertController(title: "Warning:", message: "Make sure you entered a name and 10 digit phone number.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            characterAlert.addAction(ok)
            self.present(characterAlert, animated: true, completion: nil)
        }
        if let user = self.user {
            // update User account
            UserAccountController.sharedController.modifyCurrentAccount(user: user, name: name, phoneNumber: phoneNumber)
        } else {
            // create new account
            UserAccountController.sharedController.createNewAccount(name: name, phoneNumber: phoneNumber)
            
            
        }
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @objc func cancelNewAccountTapped(){
        view.endEditing(true)
        if (self.user != nil) {
            self.presentingViewController?.dismiss(animated: true, completion: nil)
        } else {
        let cancelAlert = UIAlertController(title: "Are you sure?", message: "You can set up or edit your account later by tapping My Account. You won't be able to invite friends or sync to the cloud without an account.", preferredStyle: .actionSheet)
        let stayOnPage = UIAlertAction(title: "Keep setting up my account", style: .default, handler: nil)
        let setUpLater = UIAlertAction(title: "Set up later", style: .destructive) { (_) in
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }
        
        cancelAlert.addAction(stayOnPage)
        cancelAlert.addAction(setUpLater)
        
        self.present(cancelAlert, animated: true, completion: nil)
    }
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
