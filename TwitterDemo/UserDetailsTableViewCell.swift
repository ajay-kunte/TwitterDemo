//
//  UserDetailsTableViewCell.swift
//  TwitterDemo
//
//  Created by Ajay Kunte on 15/10/20.
//  Copyright © 2020 Ajay Kunte. All rights reserved.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileIconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileIconImageView.layer.cornerRadius = 8.0
    }
}
