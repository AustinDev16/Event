//
//  EditAccountViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/11/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EditAccountViewController: UIViewController {
    
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
        instructionLabel.text = "Invite friends to events, be invited to events, and sync your events across your other iOS devices by creating an account."
        self.view.addSubview(instructionLabel)
        
        let instructionLabelTop = NSLayoutConstraint(item: instructionLabel, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 8)
        let instructionLabelLeading = NSLayoutConstraint(item: instructionLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0)
        let instructionLabelTrailing = NSLayoutConstraint(item: instructionLabel, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0)
        
        self.view.addConstraints([instructionLabelTop, instructionLabelLeading, instructionLabelTrailing])
        
        // Name Label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Pick a screen name.\nThis is how your friends will identify you."
        nameLabel.numberOfLines = 0
        self.view.addSubview(nameLabel)
        
        let nameLabelTop = NSLayoutConstraint(item: nameLabel, attribute: .top, relatedBy: .equal, toItem: instructionLabel, attribute: .bottom, multiplier: 1.0, constant: 8.0)
        let nameLabelLeading = NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let nameLabelTrailing = NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        self.view.addConstraints([nameLabelTop, nameLabelLeading, nameLabelTrailing])
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
            nameLabel.text = user.name
        } else {
            self.title = "New Account"
        }
    }
    
    // MARK: - NavigationBar
    func setupNavigationBarItems(){
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(createNewAccount))
        self.navigationItem.rightBarButtonItem = done
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelNewAccountTapped))
        self.navigationItem.leftBarButtonItem = cancel
    }
    
    func createNewAccount(){
        
    }
    
    func cancelNewAccountTapped(){
        let cancelAlert = UIAlertController(title: "Are you sure?", message: "You can set up or edit your account later by tapping My Account. You won't be able to invite friends or sync to the cloud without an account.", preferredStyle: .actionSheet)
        let stayOnPage = UIAlertAction(title: "Keep setting up my account", style: .default, handler: nil)
        let setUpLater = UIAlertAction(title: "Set up later", style: .destructive) { (_) in
            self.presentingViewController?.dismiss(animated: true, completion: nil)
            
        }
        
        cancelAlert.addAction(stayOnPage)
        cancelAlert.addAction(setUpLater)
        
        self.present(cancelAlert, animated: true, completion: nil)
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
