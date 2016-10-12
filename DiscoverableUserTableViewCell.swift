//
//  DiscoverableUserTableViewCell.swift
//  Event
//
//  Created by Austin Blaser on 10/12/16.
//  Copyright © 2016 Austin Blaser. All rights reserved.
//

import UIKit

class DiscoverableUserTableViewCell: UITableViewCell {

    var nameLabel = UILabel()
    var phoneNumberLabel = UILabel()
    var inviteButton = UIButton(type: .custom)
    
    func updateWithDiscoverableGuest(user: DiscoverableUser){
        addSubViews()
        setupConstraints()
        nameLabel.text = user.userName
        phoneNumberLabel.text = "Last 4 of their number: \(user.phoneNumber)"
    }
    
    func addSubViews(){
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        inviteButton.translatesAutoresizingMaskIntoConstraints = false
        
        inviteButton.setTitle("Invite", for: .normal)
        inviteButton.setTitleColor(UIColor.black, for: .normal)
        //inviteButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        inviteButton.addTarget(self, action: #selector(inviteButtonTapped), for: .touchUpInside)
        
        
        self.contentView.addSubview(nameLabel)
        //self.contentView.addSubview(phoneNumberLabel)
        self.contentView.addSubview(inviteButton)
    }
    
    func setupConstraints(){
        // Name label
        let nameCenterY = NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self.contentView, attribute: .centerYWithinMargins, multiplier: 1.0, constant: 0)
        let nameLeading = NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: self.contentView, attribute: .leadingMargin, multiplier: 1.0, constant: 0)
        let nameTrailing = NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .lessThanOrEqual, toItem: self.contentView, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        self.contentView.addConstraints([nameCenterY, nameLeading, nameTrailing])
        
        //Invite Button
        let inviteTop = NSLayoutConstraint(item: inviteButton, attribute: .top, relatedBy: .equal, toItem: self.contentView, attribute: .topMargin, multiplier: 1.0, constant: 0)
        let inviteBottom = NSLayoutConstraint(item: inviteButton, attribute: .bottom, relatedBy: .equal, toItem: self.contentView, attribute: .bottomMargin, multiplier: 1.0, constant: 0)
        let inviteTrailing = NSLayoutConstraint(item: inviteButton, attribute: .trailing, relatedBy: .equal, toItem: self.contentView, attribute: .trailingMargin, multiplier: 1.0, constant: 0)
        let inviteWidth = NSLayoutConstraint(item: inviteButton, attribute: .width, relatedBy: .greaterThanOrEqual, toItem: inviteButton, attribute: .height, multiplier: 1.0, constant: 0)
        self.contentView.addConstraints([inviteTop, inviteBottom, inviteTrailing, inviteWidth])
        
    }
    
    func inviteButtonTapped(){
        print("invite tapped")
        
        inviteButton.setTitle("Invited!", for: .normal)
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
