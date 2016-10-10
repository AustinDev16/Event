//
//  eventDetail_GuestsViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/7/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class eventDetail_GuestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var innerContentViewDelegate: InnerContentViewDelegate?
    
    
    var guests: [Guest] {
        guard let event = innerContentViewDelegate?.event else {return []}
        return event.guests.flatMap{ $0 as? Guest}
    }
    
    var confirmedGuests: [Guest] {
        return self.guests.filter { $0.hasAcceptedInvite == true }
    }
    
    var unConfirmedGuests: [Guest] {
        return self.guests.filter { $0.hasAcceptedInvite == false}
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.brown
        
        NotificationCenter.default.addObserver(self, selector: #selector(guestListUpdated), name: NSNotification.Name(rawValue: "guestListUpdated"), object: nil)
        
    }
    
    func guestListUpdated(){
        self.tableView.reloadData()
    }


    func inviteGuestsButtonTapped(){
        print("invite guests button tapped")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var sections = 1
//        if confirmedGuests.count > 0 {
//            sections += 1
//        }
        if unConfirmedGuests.count > 0 {
            sections += 1
        }
        return sections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return confirmedGuests.count
        case 1: return unConfirmedGuests.count
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "guestCell")
        var guest: Guest?
        
        switch indexPath.section {
        case 0: // Confirmed guests
            guest = confirmedGuests[indexPath.row]
        case 1: // Unconfirmed Guests
            guest = unConfirmedGuests[indexPath.row]
        default:
            guest = nil
        }
        
        cell?.textLabel?.text = guest?.userName
        
        
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Attending (\(confirmedGuests.count))"
        case 1: return "Invited (\(unConfirmedGuests.count))"
        default: return ""
        }
    }

}
