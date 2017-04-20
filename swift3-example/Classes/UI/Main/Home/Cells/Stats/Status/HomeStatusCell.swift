//
//  HomeStatusCell.swift
//  swift3-example
//
//  Created by Quang Co on 3/23/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class HomeStatusCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    var imgBackground: UIImageView?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if let _ = self.imgBackground {
            
        } else {
            self.imgBackground = UIImageView()
            self.imgBackground?.image = UIImage(named: "stt_king.jpg")
            self.imgBackground?.backgroundColor = UIColor.globalColor()
            containerView.addSubview(self.imgBackground!)
            containerView.sendSubview(toBack: self.imgBackground!)
        }
    }
    
    override func layoutSubviews() {
        self.imgBackground?.frame = containerView.bounds
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
