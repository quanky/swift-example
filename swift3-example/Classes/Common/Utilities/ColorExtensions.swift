//
//  ColorExtensions.swift
//  swift3-example
//
//  Created by Quang Co on 3/21/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

extension UIColor {
    static func UIColorFromRGB(_ rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func globalColor() -> UIColor {
        return UIColorFromRGB(0x262e40)
    }
    
    static func globalYellowColor() -> UIColor {
        return UIColorFromRGB(0xffcb2b)
    }
    
    static func tabbarSelectedColor() -> UIColor {
        return UIColorFromRGB(0x80f2ff)
    }
    

}
