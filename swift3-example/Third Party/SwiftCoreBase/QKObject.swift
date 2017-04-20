//
//  QKObject.swift
//  SwiftCore
//
//  Created by Quang Co on 3/15/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

open class QKObject: NSObject, NSCoding {
    
    public required init(jsonObject: [String: Any]) {
//        print("Start setting values for key of object \(type(of:self))")
        super.init()
        setValuesForKeys(jsonObject)
    }
    
    public required init(jsonArray: [Any]) {
        QK.Log("Init object with array")
    }
    
    open override func setValue(_ value: Any?, forKey key: String) {
        if let newValue = value {
            let newKey = transformKeyToSwift(key)
            let property = class_getProperty(type(of:self), newKey.cString(using: .utf8))
            
            if let prop = property {
                let propType = propertyTypeFor(prop)
                if let propertyClass = NSClassFromString(propType) {
                    if propType.characters.count > 1
                        && !propType.hasPrefix("{")
                        && !propType.hasPrefix("^")
                        && !propType.hasPrefix("(")
                        && !propType.hasPrefix("[") {
                        //Start parsing known types
                        
                        if (newValue is NSArray) {
                            let isArrayKind = propertyClass.isSubclass(of: NSArray.self)
                            if isArrayKind {
                                if let arrayClass = self.classForArrayWithName(name: newKey) {
                                    QK.Log("You should declare class for array element with key \(newKey)")
                                    let listObjects = self.parseCustomObjectsForArray(rawValue: newValue, arrayClass: arrayClass)
                                    super.setValue(listObjects, forKey: newKey)
                                    return
                                } else {
                                    let listObjects = self.parseNormalObjectsForArray(rawValue: newValue)
                                    super.setValue(listObjects, forKey: newKey)
                                    return
                                }
                            }
                            //MARK: - Handle array parsing
                            
                        } else {
                            //MARK: - Handle Date parsing
                            let isDateKind = propertyClass.isSubclass(of: NSDate.self)
                            if (newValue is String &&  isDateKind) {
                                QK.Log("Found date value \(newValue) for key \(newKey)")
                                //Should use some specific
                                return
                            }
                            //MARK: - Handle URL parsing
                            let isURLKind = propertyClass.isSubclass(of: NSURL.self)
                            if (newValue is String &&  isURLKind) {
                                if let url = URL(string: (newValue as! String)) {
                                    super.setValue(url, forKey: newKey)
                                    return
                                }
                                
                            }
                            //MARK: - Handle Object (Dictionary) parsing
                            let isDictionaryKind = propertyClass.isSubclass(of: QKObject.self)
                            if (newValue is NSDictionary &&  isDictionaryKind) {
                                if let objectValue = self.parseValueForObject(value: newValue, objectClass: propertyClass) {
                                    super.setValue(objectValue, forKey: newKey)
                                    return
                                }
                            }
                        }
                    }
                }
            } else {
                QK.Log("Couldnt find property associated with key \(newKey)")
                return
            }
            super.setValue(value, forKey: key)
        } else {
            QK.Log("Will ignore nil value for key \(key)")
        }
    }
    
    //MARK: - Parser
    private func parseValueForObject(value: Any?, objectClass: AnyClass) -> Any? {
        if let className = objectClass as? QKObject.Type, let dict = value as? [String: Any] {
            let objectValue = className.init(jsonObject: dict)
            return objectValue
        }
        return nil
    }
    
    private func parseCustomObjectsForArray(rawValue: Any?, arrayClass: AnyClass) -> [Any] {
        var listObjects: [Any] = []
        if let listValues = rawValue as? [[String: Any]] {
            for singleValue in listValues {
                if let objectValue = parseValueForObject(value: singleValue, objectClass: arrayClass) {
                    listObjects.append(objectValue)
                }
            }
        }
        return listObjects
    }
    
    private func parseNormalObjectsForArray(rawValue: Any?) -> [Any] {
        var listObjects: [Any] = []
        if let listValues = rawValue as? [Any] {
            for singleValue in listValues {
                listObjects.append(singleValue)
            }
        }
        return listObjects
    }
    
    
    //MARK : - Private
    private func transformKeyToSwift(_ key: String) -> String {
        return key
    }
    
    private func propertyTypeFor(_ property: objc_property_t)-> String {
        if let attributes = property_getAttributes(property) {
            let chars = String(cString: attributes)
            let charsArray = chars.components(separatedBy: "\"")
            if chars[chars.startIndex] == "T" && chars[chars.index(chars.startIndex, offsetBy: 1)] != "@" {
                // it's a C primitive type
                
            } else if chars[chars.startIndex] == "T" && chars[chars.index(chars.startIndex, offsetBy: 1)] == "@" {
                // it's another Object type
            }
            
            if charsArray.count > 2 {
                return charsArray[1]
            }
        }
        
        return "INVALID"
    }
    
    
    private func classForArrayWithName(name: String) -> AnyClass? {
        let entryClassSelector = NSSelectorFromString("\(name)Class")
        if self.responds(to: entryClassSelector) {
            if let result = self.perform(entryClassSelector).takeRetainedValue() as? AnyClass {
                return result
            }
        }
        return nil
    }
    
    
    
    
    override public init() {
        
    }
    //MARK : - Serialization
    required public init?(coder aDecoder: NSCoder) {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        
    }
}
