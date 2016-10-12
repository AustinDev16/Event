//
//  InviteGuestViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/12/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class InviteGuestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    var event: Event?
    var filteredResults: [DiscoverableUser] = []
    var searchController: UISearchController?

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Invite Friends to \(event?.name)"
        tableView.dataSource = self
        tableView.delegate = self
        
        setUpSearchController()
        // Do any additional setup after loading the view.
    }
    // MARK: - Search controller
    func setUpSearchController(){
        searchController = UISearchController(searchResultsController: self)
        guard let searchController = searchController else { return }
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a friend"
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
        
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    // MARK: - TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: "inviteGuestCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "inviteGuestCell")
        }
        
        let user = filteredResults[indexPath.row]
        cell.textLabel?.text = user.userName
        cell.detailTextLabel?.text = user.phoneNumber
        
        return cell
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
