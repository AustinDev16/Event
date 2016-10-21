//
//  EventDetailViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/7/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit
import EventKitUI

class EventDetailViewController: UIViewController, InnerContentViewDelegate {
    
    var event: Event?
    var editEventButton = UIBarButtonItem()
    var groupGuestsButton = UIBarButtonItem()
    var newListButton = UIBarButtonItem()
    
    func editEventBarButtonTapped(){
        
    }
    
    func groupsGuestsButtonTapped(){
    }
    
    func newListButtonTapped(){
    }
    // MARK: - Bar Button Setup
    
    func setUpBarButtons(){
        editEventButton.title = "Edit Event"
        editEventButton.style = .plain
        editEventButton.target = detailViewController
        editEventButton.action = #selector(editEventBarButtonTapped)
        
        groupGuestsButton.title = "Groups"
        groupGuestsButton.style = .plain
        groupGuestsButton.target = guestsViewController
        groupGuestsButton.action = #selector(groupsGuestsButtonTapped)
        
        newListButton.title = "New List"
        newListButton.style = .plain
        newListButton.target = listsViewController
        newListButton.action = #selector(newListButtonTapped)
    }
    
    
    // MARK: - Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var innerContentView: UIView!
    
    // MARK: - innerContentView Properties
    
//    lazy var detailViewController: EventDetail_DetailViewController = {
//       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let viewController = storyboard.instantiateViewController(withIdentifier: "eventDetail_Detail") as! EventDetail_DetailViewController
//        
//        viewController.innerContentViewDelegate = self
//        return viewController
//    }()
    
    lazy var detailViewController: CalendarViewController = {
        let viewController = CalendarViewController()
        if let event = self.event {
            viewController.updateWithEvent(event: event)
            viewController.innerContentViewDelegate = self
        }
        return viewController
    }()
    
    lazy var listsViewController: EventDetail_ListsViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "eventDetail_Lists") as! EventDetail_ListsViewController
        viewController.innerContentViewDelegate = self
        return viewController
    }()
    
    lazy var guestsViewController: EventDetail_GuestsViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "eventDetail_Guests") as! EventDetail_GuestsViewController
        viewController.innerContentViewDelegate = self
        return viewController
    }()
    
    lazy var innerContentViewControllers: [UIViewController] = {
        return [self.detailViewController, self.listsViewController, self.guestsViewController]
    }()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSegmentedControl()
        self.definesPresentationContext = true
        
        self.innerContentView.backgroundColor = UIColor.white
        
        self.title = event?.name
        updateInnerContentView()
        setUpBarButtons()
        updateNavigationBarButtons()
        // Do any additional setup after loading the view.
    }
    
 
    func setUpSegmentedControl(){
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Details", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Lists", at: 1, animated: false)
        //segmentedControl.insertSegment(withTitle: "Guests", at: 2, animated: false)
        
        segmentedControl.addTarget(self, action: #selector(segmentSelectionChanged(sender:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = AppearanceController.purpleColor
        segmentedControl.tintAdjustmentMode = .automatic
        
        for viewController in self.innerContentViewControllers {
            addViewControllerAsChild(viewController: viewController)
        }
    }

    func segmentSelectionChanged(sender: UISegmentedControl){
        updateInnerContentView()
        updateNavigationBarButtons()
        
    }
    
    func updateInnerContentView(){
        let index = segmentedControl.selectedSegmentIndex
        
        if guestsViewController.searchController?.isActive == true {
           guestsViewController.searchController?.dismiss(animated: false, completion: nil)
            guestsViewController.searchController?.isActive = false
        }
        
        for viewController in self.innerContentViewControllers {
            viewController.view.isHidden = true
        }
        
        let selectedViewController = self.innerContentViewControllers[index]
        selectedViewController.view.isHidden = false
    }
    
    func addViewControllerAsChild(viewController: UIViewController){
        // add child view controller
        self.addChildViewController(viewController)
        
        // add child as subview
        
        innerContentView.addSubview(viewController.view)
        
        // Configure child view
        viewController.view.frame = innerContentView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Notify Child ViewController
        
        viewController.didMove(toParentViewController: self)

    }
    
    func updateNavigationBarButtons(){ // configures the navigation bar for each innerContent view when it is selected
      
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.navigationItem.rightBarButtonItem = editEventButton
        case 1:
            self.navigationItem.rightBarButtonItem = newListButton
        case 2:
            self.navigationItem.rightBarButtonItem = nil//groupGuestsButton
        default:
            return
        }
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

