//
//  HomeTabsCell.swift
//  swift3-example
//
//  Created by Quang Co on 3/23/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class HomeTabsCell: UITableViewCell {
    
    @IBOutlet weak var vwStats: HomeTabView!
    @IBOutlet weak var vwMessages: HomeTabView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwStats.setActive(true)
        vwMessages.setActive(false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnStatsClicked() {
        vwStats.setActive(true)
        vwMessages.setActive(false)
    }
    
    @IBAction func btnMessageClicked() {
        vwStats.setActive(false)
        vwMessages.setActive(true)
    }
    
}

class HomeTabView: UIView {
    @IBOutlet weak var lblTitle: UILabel!
    var isActive = true
    func setActive(_ active: Bool) {
        isActive = active
        if isActive {
            self.backgroundColor = UIColor.UIColorFromRGB(0x40486a)
            self.lblTitle.textColor = UIColor.globalYellowColor()
        } else {
            self.backgroundColor = UIColor.UIColorFromRGB(0x1f232f)
            self.lblTitle.textColor = UIColor.UIColorFromRGB(0x656c8e)
        }
        
    }
}
