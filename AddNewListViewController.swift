//
//  AddNewListViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/27/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class AddNewListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, NewListItemDelegate {
    
    var event: Event?
    
    // MARK: - NewListItemDelegate methods
    func addListItem(cell: EditableListItemTableViewCell) {
        guard let text = cell.listItemText else { return }
        let newItem = PendingListItem(name: text)
        listItems.append(newItem)
        self.tableView.reloadData()
    }
    
    func editListItem(cell: EditableListItemTableViewCell) {
        guard let updatedText = cell.editedListItemText,
        let pendingItem = cell.pendingItem,
        let index = listItems.index(of: pendingItem) else  { return }
        let toEditItem = listItems[index]
        toEditItem.name = updatedText
        self.tableView.reloadData()
    }
    
    func reloadTableViewData() {
        self.tableView.reloadData()
    }

    @IBAction func createButtonTapped(_ sender: AnyObject) {
        guard let event = self.event,
        let title = listTitle.text, title.characters.count > 0 else { return }
        // Create new checklist
        ChecklistController.sharedController.createNewCheckList(name: title, event: event)
        guard let newChecklist = ChecklistController.sharedController.findChecklistWith(name: title, forEvent: event) else  { return }
        // Create new checklist items
        for item in listItems {
            ChecklistController.sharedController.addItemToList(name: item.name, checklist: newChecklist, event: event)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBOutlet weak var createButton: UIBarButtonItem!
    @IBOutlet weak var listTitle: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    
    var listItems: [PendingListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        self.navigationItem.leftBarButtonItem = cancel
        
        self.title = ""
        self.listTitle.placeholder = "Checklist name"
        self.listTitle.delegate = self
        self.listTitle.returnKeyType = .done
        self.listTitle.autocapitalizationType = .words
        // Do any additional setup after loading the view.
        if self.title?.characters.count == 0 {
            self.createButton.isEnabled = false
        }
        
        self.listTitle.addTarget(self, action: #selector(updateTitleText), for: .editingChanged)
    }
    
    func cancelButtonTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - TextField delegate methods
    
    func updateTitleText(_ textField: UITextField){
        if let text = textField.text {
            self.title = text
            if self.title?.characters.count == 0 {
                self.createButton.isEnabled = false
            } else {
                self.createButton.isEnabled = true
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            self.title = text
            if self.title?.characters.count == 0 {
                self.createButton.isEnabled = false
            } else {
                self.createButton.isEnabled = true
            }
        }
        textField.resignFirstResponder()
        return true
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
            cell?.isPlaceHolderCell = true
        } else {
            let listItem = listItems[indexPath.row]
            cell?.updateWithPendingListItem(listItem: listItem)
            cell?.isPlaceHolderCell = false
            cell?.pendingItem = listItem
        }
        
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == listItems.count {
            return false
        } else {
            return true
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            listItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

/*
 // MARK: - Protocol: NewListItemDelegate
 */
protocol NewListItemDelegate: class {
    func addListItem(cell: EditableListItemTableViewCell)
    func editListItem(cell: EditableListItemTableViewCell)
    func reloadTableViewData()
}

// MARK: - Supporting Classes
class PendingListItem: Equatable {
    var name: String
    init(name: String){
        self.name = name
    }
    static func ==(rhs: PendingListItem, lhs: PendingListItem) -> Bool {
        return rhs.name == lhs.name
    }
}
