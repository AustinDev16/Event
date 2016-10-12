//
//  eventDetail_ListsViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/7/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class eventDetail_ListsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  ListItemDelegate {
    
    
    let tableView = UITableView()
    weak var innerContentViewDelegate: InnerContentViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        setupTableView()
        tableView.reloadData()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.bounds = view.frame
        tableView.delegate = self
        tableView.dataSource = self
        
        let tableViewTop = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        let tableViewLeading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        let tableViewTrailing = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let tableViewBottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraints([tableViewTop, tableViewBottom, tableViewLeading, tableViewTrailing])
    }
    
    
    
    func newListButtonTapped(){
        let newListAlertController = UIAlertController(title: "New list", message: nil, preferredStyle: .alert)
        
        newListAlertController.addTextField { (textField) in
            textField.placeholder = "List name"
            textField.autocapitalizationType = .words
            textField.returnKeyType = .default
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let create = UIAlertAction(title: "Create list", style: .default) { (_) in
            guard let textField = newListAlertController.textFields?.first,
                let name = textField.text, name.characters.count > 0,
                let event = self.innerContentViewDelegate?.event else { return }
            
            textField.resignFirstResponder()
            ChecklistController.sharedController.createNewCheckList(name: name, event: event)
            self.tableView.reloadData()
        }
        
        newListAlertController.addAction(cancel)
        newListAlertController.addAction(create)
        self.present(newListAlertController, animated: true, completion: nil)
    }
    
    // MARK: - List Item Delegate
    
    func checkBoxTapped(cell: ListItemTableViewCell) {
        print("Check box tapped")
        guard let listItem = cell.listItem else { return }
        
        // toggle checklist
        ChecklistController.sharedController.toggleIsDone(listItem: listItem)
        cell.updateWithItem(item: listItem)
    }
    
    func responsiblePartyTapped(cell: ListItemTableViewCell) {
        print("Responsible party tapped")
    }
    
    // MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("nuber of sections")
        guard let event = innerContentViewDelegate?.event else {  print("error")
            return 0}
        print(event.checklists.count)
        return event.checklists.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let checklists = innerContentViewDelegate?.event?.checklists,
            let checklist = checklists[section] as? Checklist else {return 0}
        print("list items: \(checklist.listItems.count)")
        return checklist.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ListItemTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "listItemCell") as? ListItemTableViewCell
        
        if cell == nil {
            cell = ListItemTableViewCell(style: .default, reuseIdentifier: "listItemCell")
        }
        
        guard  let checklists = innerContentViewDelegate?.event?.checklists,
            let checklist = checklists[indexPath.section] as? Checklist else { return UITableViewCell() }
        
        let items = checklist.listItems.flatMap { $0 as? ListItem}
        
        cell.updateWithItem(item: items[indexPath.row])
        cell.listItem = items[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let event = innerContentViewDelegate?.event,
                let checklist = event.checklists[indexPath.section] as? Checklist,
                let itemToDelete = checklist.listItems[indexPath.row] as? ListItem else { return }
            
            
            
            ChecklistController.sharedController.removeItemFromList(listItem: itemToDelete, checklist: checklist)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // MARK: - Header views
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerViewForSection(section: section)
    }
    
    func headerViewForSection(section: Int) -> UIView {
        guard let event = innerContentViewDelegate?.event else { return UIView()}
        let checklists = event.checklists.flatMap { $0 as? Checklist}
        let title = checklists[section].name
        let view = UIView()
        view.bounds = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 30)
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        view.addSubview(titleLabel)
        
        let titleLabelCenterY = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        let titleLabelLeading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0)
        let titleLabelTrailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0)
        
        view.addConstraints([titleLabelCenterY, titleLabelLeading, titleLabelTrailing])
        
        // Add Button
        let addButton = UIButton(type: .custom)
        addButton.tag = section
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(UIColor.black, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(self.addListItemButtonTapped), for: .touchUpInside)
        view.addSubview(addButton)
        
        let addButtonCenterY = NSLayoutConstraint(item: addButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        let addButtonTrailing = NSLayoutConstraint(item: addButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let addButtonWidth = NSLayoutConstraint(item: addButton, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: addButton, attribute: .height, multiplier: 1.0, constant: 0)
        view.addConstraints([addButtonCenterY, addButtonTrailing, addButtonWidth])
        
        // Delete button
        let trashButton = UIButton()
        trashButton.tag = section
        trashButton.setTitle("Delete", for: .normal)
        trashButton.setTitleColor(UIColor.black, for: .normal)
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        trashButton.addTarget(self, action: #selector(self.deleteCheckListTapped(sender:)), for: .touchUpInside)
        view.addSubview(trashButton)
        
        let trashButtonCenterY = NSLayoutConstraint(item: trashButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1.0, constant: 0)
        let trashButtonTrailing = NSLayoutConstraint(item: trashButton, attribute: .trailing, relatedBy: .equal, toItem: addButton, attribute: .leadingMargin, multiplier: 1.0, constant: -20.0)
        let trashButtonWidth = NSLayoutConstraint(item: trashButton, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: trashButton, attribute: .height, multiplier: 1.0, constant: 0)
        view.addConstraints([trashButtonCenterY, trashButtonTrailing, trashButtonWidth])
        
        return view
    }
    
    // MARK: - Add Actions
    func deleteCheckListTapped(sender: Any){
        guard let button = sender as? UIButton,
        let event = innerContentViewDelegate?.event,
        let checklist = event.checklists[button.tag] as? Checklist else {return}
        
        let deleteAlertController = UIAlertController(title: nil, message: "Erasing this list will delete all of it's items.", preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "Delete checklist", style: .destructive) { (_) in
            ChecklistController.sharedController.deleteCheckList(checklist: checklist, event: event)
            self.tableView.reloadData()
        }
        deleteAlertController.addAction(cancel)
        deleteAlertController.addAction(delete)
        
        self.present(deleteAlertController, animated: true, completion: nil)
        
        
        
    }
    
    func addListItemButtonTapped(sender: Any){
        guard let button = sender as? UIButton,
            let event = innerContentViewDelegate?.event,
            let checklist = event.checklists[button.tag] as? Checklist else {return}
        
        // Alert controller
        let newListItemAlertController = UIAlertController(title: "New item", message: "For list: \(checklist.name)", preferredStyle: .alert)
        newListItemAlertController.addTextField { (textField) in
            textField.placeholder = "New item"
            textField.autocapitalizationType = .sentences
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let add = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let textField = newListItemAlertController.textFields?.first,
                let name = textField.text,
                name.characters.count > 0 else { return }
            
            textField.resignFirstResponder()
            
            ChecklistController.sharedController.addItemToList(name: name, checklist: checklist, event: event)
            self.tableView.reloadData()
        }
        newListItemAlertController.addAction(cancel)
        newListItemAlertController.addAction(add)
        self.present(newListItemAlertController, animated: true, completion: nil)
        
        
    }
}
