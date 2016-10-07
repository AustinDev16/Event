//
//  EventDetailViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/7/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, InnerContentViewDelegate {
    
    var event: Event?
    
    // MARK: - Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var innerContentView: UIView!
    
    // MARK: - innerContentView Properties
    
    lazy var detailViewController: eventDetail_DetailViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "eventDetail_Detail") as! eventDetail_DetailViewController
        
        viewController.delegate = self
        return viewController
    }()
    
    lazy var listsViewController: eventDetail_ListsViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "eventDetail_Lists") as! eventDetail_ListsViewController
        viewController.delegate = self
        return viewController
    }()
    
    lazy var guestsViewController: eventDetail_GuestsViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "eventDetail_Guests") as! eventDetail_GuestsViewController
        viewController.delegate = self
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
        
        self.title = event?.name
        // Do any additional setup after loading the view.
    }
    
    func setUpSegmentedControl(){
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Details", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Lists", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Guests", at: 2, animated: false)
        
        segmentedControl.addTarget(self, action: #selector(segmentSelectionChanged(sender:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
        
        for viewController in self.innerContentViewControllers {
            addViewControllerAsChild(viewController: viewController)
        }
    }

    func segmentSelectionChanged(sender: UISegmentedControl){
        updateInnerContentView()
    }
    
    func updateInnerContentView(){
        let index = segmentedControl.selectedSegmentIndex
        
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
