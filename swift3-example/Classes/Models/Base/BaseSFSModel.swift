//
//  BaseSFSModel.swift
//  swift3-example
//
//  Created by Quang Co on 3/23/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class BaseSFSModel: QKObject {
    
    var rawSFSOBject: SFSObject?
    
    
    convenience init(sfsObject: SFSObject) {
        if let dumpData = sfsObject.getDump(false) {
            var dataText = dumpData;
            var index = dataText.index(dataText.startIndex, offsetBy: 1)
            dataText = dataText.substring(from: index)
            index = dataText.index(dataText.startIndex, offsetBy: dataText.characters.count - 1)
            dataText = dataText.substring(to: index)
            if let dict = BaseSFSModel.extractPropsToDict(text: dataText) {
                self.init(jsonObject: dict)
                self.rawSFSOBject = sfsObject;
            } else {
                self.init()
            }
        } else {
            self.init()
        }
    }
    
    static func extractPropsToDict(text: String) -> [String: Any]?{
        let listProps = text.components(separatedBy: ";")
        var rs: [String: Any] = [:]
        for propString in listProps {
            //Example: "(utf_string) fullname: new name"
            let parts = propString.components(separatedBy: ")")
            if (parts.count == 2) {
                //part[0]: "(utf_string"
                var propType = parts[0]
                let index = propType.index(propType.startIndex, offsetBy: 1)
                propType = propType.substring(from: index)
                //part[1]: " fullname: new name"
                let propsDetail = parts[1].components(separatedBy: ":")
                if propsDetail.count == 2 {
                    let  propName = propsDetail[0].trimmingCharacters(in: .whitespacesAndNewlines)
                    let  propValue = propsDetail[1].trimmingCharacters(in: .whitespacesAndNewlines)
                    rs[propName] = propValue
                }
            }
            
        }
        return rs
    }
    
    
}
