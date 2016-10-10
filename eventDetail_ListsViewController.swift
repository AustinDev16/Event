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
        // Do any additional setup after loading the view.
        
        
    }
    
    func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tableView)
        tableView.bounds = view.frame
        tableView.delegate = self
        
        let tableViewTop = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0)
        let tableViewLeading = NSLayoutConstraint(item: tableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0)
        let tableViewTrailing = NSLayoutConstraint(item: tableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0)
        let tableViewBottom = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        self.view.addConstraints([tableViewTop, tableViewBottom, tableViewLeading, tableViewTrailing])
    }

    
    
    func newListButtonTapped(){
        print("new list button tapped")
    }
    
    // MARK: - List Item Delegate
    
    func checkBoxTapped(cell: ListItemTableViewCell) {
        
    }
    
    func responsiblePartyTapped(cell: ListItemTableViewCell) {
        
    }
    
    // MARK: TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let checklists = innerContentViewDelegate?.event?.checklists else {return 0}
        print("Checklists:\(checklists.count)")
        return checklists.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let checklists = innerContentViewDelegate?.event?.checklists,
         let checklist = checklists[section] as? Checklist else {return 0}
       print("list items: \(checklist.listItems.count)")
        return checklist.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell") as! ListItemTableViewCell
        guard let checklists = innerContentViewDelegate?.event?.checklists,
         let checklist = checklists[indexPath.section] as? Checklist else { return UITableViewCell() }
     
        let items = checklist.listItems.flatMap { $0 as? ListItem}
        
        cell.updateWithItem(item: items[indexPath.row])
        cell.listItem = items[indexPath.row]
        cell.delegate = self
        return cell
    }
  

}
