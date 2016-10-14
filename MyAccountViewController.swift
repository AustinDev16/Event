//
//  MyAccountViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/11/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var userIDLabel: UILabel!
    
    var user: User? {
        return UserAccountController.sharedController.hostUser
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "My Account"
        updateViews()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        updateViews()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateViews(){
        if (UserAccountController.sharedController.hasAccount() == false){
            
        } else {
            if let user = self.user {
                screenNameLabel.text = user.name
                phoneNumberLabel.text = user.phoneNumber
                userIDLabel.text = user.userID
                
                let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
                self.navigationItem.rightBarButtonItem = editButton
            }
        }
    }
    
    // MARK: - Button Actions
    func editButtonTapped(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let navigationController = storyboard.instantiateViewController(withIdentifier: "editAccountNavigationController") as? UINavigationController,
        let editVC = navigationController.viewControllers.first as? EditAccountViewController else { return }
        
        editVC.user = self.user
        
        
        
        self.present(navigationController, animated: true, completion: nil)
        

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
