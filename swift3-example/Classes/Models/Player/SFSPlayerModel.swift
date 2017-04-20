//
//  SFSPlayerModel.swift
//  swift3-example
//
//  Created by Quang Co on 4/11/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class SFSPlayerModel: BaseSFSModel {
    var battletag: String = ""
    var display: String = ""
    var id: Int = 0
    
    override var description: String {
        return "\(display): \(battletag)"
    }
}
