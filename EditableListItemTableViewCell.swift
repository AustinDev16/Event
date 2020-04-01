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
    weak var delegate: NewListItemDelegate?
    var listItemText: String?
    var editedListItemText: String?
    var isPlaceHolderCell: Bool = false
    var pendingItem: PendingListItem?
    var hasCapturedTextField: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithPendingListItem(listItem: PendingListItem){
        self.textField.text = listItem.name
    }
    
    func updateAsEditableCell(){
        self.pendingItem = nil
        self.textField.text = nil
        setUpEditableCell()
    }
    
    func setUpEditableCell(){
        textField.delegate = self
        textField.placeholder = "New list item"
        textField.autocapitalizationType = .sentences
        textField.autocorrectionType = .yes
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .done
        
        self.contentView.addSubview(textField)
        
        let textFieldLeading = NSLayoutConstraint(item: textField, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let textFieldTrailing = NSLayoutConstraint(item: textField, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let textFieldTop = NSLayoutConstraint(item: textField, attribute: .top, relatedBy: .equal, toItem: contentView, attribute: .topMargin, multiplier: 1.0, constant: 0)
        let textFieldBottom = NSLayoutConstraint(item: textField, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottomMargin, multiplier: 1.0, constant: 0)
        self.contentView.addConstraints([textFieldLeading, textFieldTrailing, textFieldTop, textFieldBottom])
    }
    
    // MARK: - TextField delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hasCapturedTextField = false
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // communicate new text back to model
        if isPlaceHolderCell {
            if let text = textField.text, text.count > 0 {
                self.listItemText = text
                delegate?.addListItem(cell: self)
            }
        } else {
            if let text = textField.text, text.count > 0 {
                self.editedListItemText = text
                delegate?.editListItem(cell: self)
            }
        }
        
        hasCapturedTextField = true
        // add a new blank cell to the row
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        // to catch a move from one text field to another without
        if hasCapturedTextField == false {
            if isPlaceHolderCell {
                if let text = textField.text, text.count > 0 {
                    self.listItemText = text
                    delegate?.addListItem(cell: self)
                }
            } else {
                if let text = textField.text, text.count > 0 {
                    self.editedListItemText = text
                    delegate?.editListItem(cell: self)
                }
            }
        }
    }

}
