//
//  AddNewListViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/27/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class AddNewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBAction func createButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var listTitle: UITextField!
    @IBOutlet weak var tableView: UITableView!
    let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    
    var listItems: [ListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.navigationItem.leftBarButtonItem = self.cancel
        
        self.title = ""
        self.listTitle.placeholder = "Add a title"
        self.listTitle.delegate = self
        self.listTitle.returnKeyType = .done        
        // Do any additional setup after loading the view.
    }
    
    func cancelButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TextField delegate methods
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            self.title = text
        }
        textField.resignFirstResponder()
        return true
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        if let text = textField.text {
//            self.title = text
//        }
//        return true
//    }

    // MARK: - TableView Delegate/Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editableListItem", for: indexPath) as? EditableListItemTableViewCell
        
        let newCellIndex = listItems.count
        if indexPath.row == newCellIndex {
            cell?.updateAsEditableCell()
        } else {
            let listItem = listItems[indexPath.row]
            cell?.updateWithPendingListItem(listItem: listItem)
        }
        return cell ?? UITableViewCell()
    }
    


}
