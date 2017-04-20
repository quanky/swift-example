//
//  QKStringExtension.swift
//  SwiftCore
//
//  Created by Quang Co on 3/20/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit


extension String {
    func URLEncodedString() -> String {
        var encodedString = self.replacingOccurrences(of: "•", with: "-")
        encodedString = encodedString.replacingOccurrences(of: "€", with: "Euro")
        return encodedString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
//        let encodedCFString = encodedString as CFString
//        let returnCFString = CFURLCreateStringByAddingPercentEscapes(nil,
//                                                                     encodedCFString,
//                                                                     nil,
//                                                                     "!*'();:@&=+$,/?%#[]" as CFString,
//                                                                     CFStringBuiltInEncodings.isoLatin1.rawValue)
//        return returnCFString as! String

    }
    
  
}
