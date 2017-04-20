//
//  BattleInviteCell.swift
//  swift3-example
//
//  Created by Quang Co on 4/11/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class BattleInviteCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTag: UILabel!
    @IBOutlet weak var btnInvite: UIButton!
    
    var playerData: SFSPlayerModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnInviteClicked() {
        if let data = playerData {
            let invite = [data.id]
            SFSRequestManager.sharedManager.sendStartGameRequest(invite)
        }
    }
    
}
