//
//  FeedTableViewCell.swift
//  JohoFeed
//
//  Created by HAGANE on 11/21/16.
//  Copyright © 2016 Evan Juárez. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
