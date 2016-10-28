//
//  AddNewListViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/27/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class AddNewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBAction func createButtonTapped(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var listTitle: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var listItems: [ListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        preferredContentSize = CGSize(width: 0, height: tableView.contentSize.height)
        
        // Do any additional setup after loading the view.
    }

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
