//
//  NewsFeedTableViewCell.swift
//  VKTestApp
//
//  Created by Мария Матичина on 5/18/20.
//  Copyright © 2020 Мария Матичина. All rights reserved.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoView: WebImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

