//
//  eventDetail_DetailViewController.swift
//  Event
//
//  Created by Austin Blaser on 10/7/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class eventDetail_DetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var innerContentViewDelegate: InnerContentViewDelegate?
    
    func editEventButtonTapped(){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let navigationController = storyboard.instantiateViewController(withIdentifier: "editEventNavigationController") as? UINavigationController,
        let editVC = navigationController.viewControllers.first as? EditEventViewController else { return }
        
        editVC.event = innerContentViewDelegate?.event

        present(navigationController, animated: true, completion: nil)
            
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor.clear
        updateView()
    }

    func updateView(){
        guard let event = innerContentViewDelegate?.event else { return }
        eventName.text = event.name
        let date = event.date as Date
        dateLabel.text = EventController.dateFormatter.string(from: date)
        locationLabel.text = "@ \(event.location)"
        descriptionLabel.text = event.detailDescription
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
