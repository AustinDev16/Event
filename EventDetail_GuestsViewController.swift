//
//  eventDetail_GuestsViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/7/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EventDetail_GuestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, InviteGuestDelegate, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate {
    
    
    weak var innerContentViewDelegate: InnerContentViewDelegate?
    
    var searchController: UISearchController?
    
    
    var guests: [Guest] {
        guard let event = innerContentViewDelegate?.event else {return []}
        return event.guests.compactMap{ $0 as? Guest}
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
        setupSearchController()
    }
    
    
    // MARK: Search Results Methods
    
    func setupSearchController(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let resultsController = storyboard.instantiateViewController(withIdentifier: "inviteGuestsSearchController")
        searchController = UISearchController(searchResultsController: resultsController)
        
        guard let searchController = searchController else { return }
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Invite a friend"
        searchController.searchBar.delegate = self
        self.definesPresentationContext = true
       
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let name = searchController.searchBar.text,
            let resultsController = searchController.searchResultsController as? InviteGuestSearchTableViewController else { return}
        resultsController.filteredResults = GuestController.searchForGuest(name: name)
        resultsController.inviteGuestDelegate = self
        
        resultsController.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("cancel tapped")
    }
    
    // MARK: - InviteGuestDelegate
    func inviteGuestButtonTapped(cell: DiscoverableUserTableViewCell) {
        guard let event = innerContentViewDelegate?.event,
        let user = cell.discoverableUser else { return }
        EventController.sharedController.addGuest(newGuest: user, event: event)
        
        cell.inviteButton.setTitle("Invited!", for: .normal)
        
        self.tableView.reloadData()
    }
    
    //MARK: - OTHER methods
    @objc func guestListUpdated(){
        self.tableView.reloadData()
    }


    @objc func inviteGuestsButtonTapped(){
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
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Uninvite"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let event = self.innerContentViewDelegate?.event else {return}
            var guest: Guest
            switch indexPath.section {
            case 0:
                guest = self.confirmedGuests[indexPath.row]
            case 1:
                guest = self.unConfirmedGuests[indexPath.row]
            default:
                return
            }
            EventController.sharedController.removeGuest(guest: guest, event: event)
            

            //tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            
        }
    }

}
