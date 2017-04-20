//
//  HomeGeneralCell.swift
//  swift3-example
//
//  Created by Quang Co on 3/23/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class HomeGeneralCell: UITableViewCell {
    
    @IBOutlet weak var lblQuizkingz: UILabel!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblTagTitle: UILabel!
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var lblLevelTitle: UILabel!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var lblLevelProgress: UILabel!
    @IBOutlet weak var lblExp: UILabel!
    @IBOutlet weak var lblTrophy: UILabel!
    @IBOutlet weak var lblToken: UILabel!
    @IBOutlet weak var lblGem: UILabel!
    
    var imgBackground: UIImageView?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblQuizkingz.textColor = UIColor.globalYellowColor()
        lblTag.textColor = UIColor.globalYellowColor()
        lblTagTitle.textColor = UIColor.globalYellowColor()
        lblExp.textColor = UIColor.globalYellowColor()
        lblFullname.textColor = UIColor.white
        lblLevel.textColor = UIColor.white
        lblLevelTitle.textColor = UIColor.white
        lblLevelProgress.textColor = UIColor.white
//        lblFullname.textColor = UIColor.white
        
        if let _ = self.imgBackground {
            
        } else {
            self.imgBackground = UIImageView()
            self.imgBackground?.image = UIImage(named: "")
            self.imgBackground?.backgroundColor = UIColor.globalColor()
            addSubview(self.imgBackground!)
            self.sendSubview(toBack: self.imgBackground!)
        }
    }
    
    override func layoutSubviews() {
        self.imgBackground?.frame = self.bounds
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData() {
        if let account = SFSAccountManager.userManager.currentUser {
            lblFullname.text = "\(account.fullname) - ID: \(account.id)"
            lblLevel.text = "\(account.level)"
            lblTag.text = "\(account.battletag)"
        }
    }
    
}
