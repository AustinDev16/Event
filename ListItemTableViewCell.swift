//
//  ListItemTableViewCell.swift
//  CustomListItemCells
//
//  Created by Austin Blaser on 10/8/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class ListItemTableViewCell: UITableViewCell {

 
    weak var delegate: ListItemDelegate?
    var listItem: ListItem?
    // MARK: - UIElements
    
    var itemNameLabel = UILabel()
    var checkBox = UIButton()
    var responsibleParty = UIButton()
    
    // MARK: - Update Cell
    func updateWithItem(item: ListItem){
        addElementsToView()
        
        applyLayoutConstraints()
        configureButtonActions()
        
        //
        if item.isComplete{
            checkBox.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            checkBox.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
        
        itemNameLabel.text = item.name
        responsibleParty.setImage(nil, for: .normal)
        //responsibleParty.setImage(#imageLiteral(resourceName: "GreenFollower"), for: .normal)
    }
    
    func applyLayoutConstraints(){
        // CheckBox button
        let checkBoxTop = NSLayoutConstraint(item: self.checkBox, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .top, multiplier: 1.0, constant: 4)
        let checkBoxLeading = NSLayoutConstraint(item: self.checkBox, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let checkBoxBottom = NSLayoutConstraint(item: self.checkBox, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottom, multiplier: 1.0, constant: -4)
        let checkBoxWidth = NSLayoutConstraint(item: self.checkBox, attribute: .width, relatedBy: .equal, toItem: self.checkBox , attribute: .height, multiplier: 1.0, constant: 0)
        self.contentView.addConstraints([checkBoxTop, checkBoxLeading, checkBoxBottom, checkBoxWidth])
        
        // Item Label
        let nameLabelLeading = NSLayoutConstraint(item: self.itemNameLabel, attribute: .leading, relatedBy: .equal, toItem: self.checkBox, attribute: .trailing, multiplier: 1.0, constant: 8)
        let nameLabelCenterY = NSLayoutConstraint(item: self.itemNameLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerY, multiplier: 1.0, constant: 0)
        let nameLabelTrailing = NSLayoutConstraint(item: self.itemNameLabel, attribute: .trailing, relatedBy: .equal, toItem: self.responsibleParty, attribute: .leading, multiplier: 1.0, constant: -8)
        self.contentView.addConstraints([nameLabelLeading, nameLabelCenterY, nameLabelTrailing])
        
        // Responsible Party (Person)
        let personTop = NSLayoutConstraint(item: self.responsibleParty, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .topMargin, multiplier: 1.0, constant: 0)
        let personBottom = NSLayoutConstraint(item: self.responsibleParty, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottomMargin, multiplier: 1.0, constant: 0.0)
        let personTrailing = NSLayoutConstraint(item: self.responsibleParty, attribute: .trailingMargin, relatedBy: .equal, toItem: self.contentView, attribute: .trailingMargin, multiplier: 1.0, constant: -8)
        let personWidth = NSLayoutConstraint(item: self.responsibleParty, attribute: .width, relatedBy: .equal, toItem: self.responsibleParty, attribute: .height, multiplier: 1.0, constant: 0)
        self.contentView.addConstraints([personTop, personBottom, personTrailing, personWidth])
    }
    
    func addElementsToView(){
        itemNameLabel.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        responsibleParty.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(itemNameLabel)
        self.contentView.addSubview(checkBox)
        self.contentView.addSubview(responsibleParty)
    }
    
    func configureButtonActions(){
        checkBox.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        responsibleParty.addTarget(self, action: #selector(responsiblePartyTapped), for: .touchUpInside)
    }
    
    @objc func checkBoxTapped(){
        delegate?.checkBoxTapped(cell: self)
    }
    
    @objc func responsiblePartyTapped(){
        delegate?.responsiblePartyTapped(cell: self)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

 
}
