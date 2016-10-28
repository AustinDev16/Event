//
//  EditableListItemTableViewCell.swift
//  Event
//
//  Created by Austin Blaser on 10/27/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class EditableListItemTableViewCell: UITableViewCell, UITextFieldDelegate {

    let textField = UITextField()
    let addButton = UIButton(type: .custom)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithPendingListItem(listItem: ListItem){
        
    }
    
    func updateAsEditableCell(){
        setUpEditableCell()
    }
    
    func setUpEditableCell(){
        textField.delegate = self
        textField.placeholder = "New list item"
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .yes
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(textField)
        
        let textFieldLeading = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let textFieldTrailing = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let textFieldTop = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1.0, constant: 0)
        let textFieldBottom = NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottomMargin, multiplier: 1.0, constant: 0)
        self.contentView.addConstraints([textFieldLeading, textFieldTrailing, textFieldTop, textFieldBottom])
    }
    
    // MARK: - TextField delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
