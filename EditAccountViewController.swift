//
//  EditAccountViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/11/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EditAccountViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "New account"
        // Do any additional setup after loading the view.
        
        setupNavigationBarItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
