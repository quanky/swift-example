//
//  HomeOverallRankCell.swift
//  swift3-example
//
//  Created by Quang Co on 3/23/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class HomeOverallRankCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.textColor = UIColor.globalYellowColor()
        lblTitle.text = "Rank:"
        lblValue.textColor = UIColor.globalYellowColor()
        containerView.backgroundColor = UIColor.globalYellowColor()
        containerView.backgroundColor = UIColor.UIColorFromRGB(0x1f232f)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
