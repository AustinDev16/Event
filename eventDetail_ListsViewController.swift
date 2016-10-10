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
        print("new list button tapped")
    }
    
    // MARK: - List Item Delegate
    
    func checkBoxTapped(cell: ListItemTableViewCell) {
        
    }
    
    func responsiblePartyTapped(cell: ListItemTableViewCell) {
        
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
        
        //cell.textLabel?.text = items[indexPath.row].name
        cell.updateWithItem(item: items[indexPath.row])
        cell.listItem = items[indexPath.row]
        cell.delegate = self
        return cell
    }
  
    // MARK: - Header views
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
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
        view.backgroundColor = UIColor.white
        
        // Title Label
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = title
        view.addSubview(titleLabel)
        
        let titleLabelTop = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0)
        let titleLabelLeading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leadingMargin, multiplier: 1.0, constant: 0.0)
        let titleLabelTrailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: 0.0)
        
        view.addConstraints([titleLabelTop, titleLabelLeading, titleLabelTrailing])
        
        // Add Button
        let addButton = UIButton(type: .custom)
        addButton.setTitle("Add", for: .normal)
        addButton.setTitleColor(UIColor.black, for: .normal)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(addButton)
        
        let addButtonBottom = NSLayoutConstraint(item: addButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        let addButtonTrailing = NSLayoutConstraint(item: addButton, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let addButtonWidth = NSLayoutConstraint(item: addButton, attribute: .width, relatedBy: .equal, toItem: addButton, attribute: .height, multiplier: 1.0, constant: 0)
        view.addConstraints([addButtonBottom, addButtonTrailing, addButtonWidth])
        
        return view
    }
}
