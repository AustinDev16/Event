//
//  AppearanceController.swift
//  Event
//
//  Created by Austin Blaser on 10/19/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation
import UIKit
import EventKitUI

class AppearanceController {
    
    static var purpleColor: UIColor {
        return UIColor(red: 81/255.0, green: 13/255.0, blue: 132/255.0, alpha: 1.0)
    }
    
    static var tanColor: UIColor {
        return UIColor(red: 255/255.0, green: 248/255.0, blue: 232/255.0, alpha: 1.0)
    }
    
    static func customizeColors(viewController: UIViewController){
        viewController.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
        viewController.navigationController!.navigationBar.barTintColor = AppearanceController.tanColor
        UIBarButtonItem.appearance().tintColor = AppearanceController.purpleColor
        UINavigationBar.appearance().tintColor = AppearanceController.purpleColor
    }
}

extension EKEventEditViewController {
    
    override open func viewWillAppear(_ animated: Bool) {
       
        self.navigationBar.barTintColor = AppearanceController.tanColor
    }
}
