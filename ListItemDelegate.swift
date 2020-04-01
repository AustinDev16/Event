//
//  ListItemDelegate.swift
//  CustomListItemCells
//
//  Created by Austin Blaser on 10/8/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import Foundation

protocol ListItemDelegate: class {
    func checkBoxTapped(cell: ListItemTableViewCell)
    func responsiblePartyTapped(cell: ListItemTableViewCell)
}
