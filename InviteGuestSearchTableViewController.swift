//
//  InviteGuestSearchTableViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/12/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class InviteGuestSearchTableViewController: UITableViewController {
    var filteredResults: [DiscoverableUser] = []
    override func viewDidLoad() {
        super.viewDidLoad()


    }

 
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return filteredResults.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "inviteGuestCell", for: indexPath) as? DiscoverableUserTableViewCell else { return UITableViewCell() }
        let guest = filteredResults[indexPath.row]
        
        cell.updateWithDiscoverableGuest(user: guest)
//        // Configure the cell...
        
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
