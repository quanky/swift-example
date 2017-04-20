//
//  HomeOtherStatsCell.swift
//  swift3-example
//
//  Created by Quang Co on 3/23/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class HomeOtherStatsCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var index = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.textColor = UIColor.white
        lblValue.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData() {
        if index % 2 == 0 {
            containerView.backgroundColor = UIColor.UIColorFromRGB(0x0c0e10)
        } else {
            containerView.backgroundColor = UIColor.UIColorFromRGB(0x1f232f)
        }

    }
}
