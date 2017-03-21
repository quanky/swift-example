//
//  QKTabbarController.swift
//  swift3-example
//
//  Created by Quang Co on 3/17/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class QKTabbarController: UITabBarController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


class QKTabbarModel {
    var title: String = ""
    var icon: String = ""
    
    convenience init(title: String, icon: String) {
        self.init()
        self.title = title
        self.icon = icon
    }
}
