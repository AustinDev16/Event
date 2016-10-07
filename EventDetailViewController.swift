//
//  EventDetailViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/7/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    var event: Event?
    
    // MARK: - Outlets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var innerContentView: UIView!
    
    // MARK: - innerContentView Properties
    
    lazy var detailViewController: eventDetail_DetailViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "eventDetail_Detail") as! eventDetail_DetailViewController
        return viewController
    }()
    
    lazy var listsViewController: eventDetail_ListsViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "eventDetail_Lists") as! eventDetail_ListsViewController
        return viewController
    }()
    
    lazy var guestsViewController: eventDetail_GuestsViewController = {
       let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "eventDetail_Guests") as! eventDetail_GuestsViewController
        return viewController
    }()
    
    // MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSegmentedControl()
        // Do any additional setup after loading the view.
    }
    
    func setUpSegmentedControl(){
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Details", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Lists", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Guests", at: 2, animated: false)
        
        segmentedControl.addTarget(self, action: #selector(segmentSelectionChanged(sender:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentIndex = 0
    }

    func segmentSelectionChanged(sender: UISegmentedControl){
        
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
