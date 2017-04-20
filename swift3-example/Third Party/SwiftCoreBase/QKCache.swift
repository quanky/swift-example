//
//  QKCache.swift
//  SwiftCore
//
//  Created by Quang Co on 3/17/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit
open class QKCache: NSObject {
    var id: String!
    var persistent = true
    var storagePath: String
    var memoryCache: NSCache<AnyObject, AnyObject>
    static var sharedInstances: [String: QKCache] = [:] ;
    static var kPropertiesKey = "QKCacheProperties"
    
    var properties: [String: AnyObject] = [:] ;
    
    
    private override init() {
        self.storagePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0].appending("/QKCache")
        self.memoryCache = NSCache()
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(emptyCache), name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    
    func emptyCache() {
        self.memoryCache .removeAllObjects()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    
    
    
    //MARK : - Public methods & Props
    open static let defaultCache: QKCache = QKCache.cacheWithID(cacheID: "INTERNAL_DEFAULT_CACHE")!
    
    open static func cacheWithID(cacheID: String) -> QKCache? {
        if cacheID == ""{
            return nil
        }
        
        if !sharedInstances.keys.contains(cacheID) {
            let cacheInstance = QKCache()
            cacheInstance.id = cacheID
//            let idDir = cacheID.URLEncodedString()
//            let dirPath = cacheInstance.storagePath.appending("/\(idDir)")
//            
//            
            sharedInstances[cacheID] = cacheInstance
        }
        
        return sharedInstances[cacheID]
    }
    
    open func clearAllData() {
        self.memoryCache.removeAllObjects()
    }
    
    private func loadProperties() {
        if let dict = NSKeyedUnarchiver.unarchiveObject(withFile: URLEncodedFilenameFromString(QKCache.kPropertiesKey)) as? [String: AnyObject] {
            self.properties = dict
        } else {
            self.properties = [:]
        }
    }
    
    private func addKVO() {
        
    }
    
    //MARK: - Tools
    private func URLEncodedFilenameFromString(_ string: String) -> String{
        let dir = self.id.URLEncodedString()
        let fileName = string.URLEncodedString()
        return self.storagePath.appending("/\(dir)/\(fileName)")
    }
    
    private func deleteObjectForKey(key: String) {
        self.memoryCache.removeObject(forKey: key as AnyObject)
        do {
            try FileManager.default.removeItem(atPath: URLEncodedFilenameFromString(key))
        } catch {
            
        }
        
    }
//    - (void)setWritableObject:(id)object forKey:(NSString *)key useMemoryCache:(BOOL)useMemoryCache
    private func setWritableObject(object: Data, key: String, useMemoryCache: Bool) {
        if useMemoryCache {
            memoryCache .setObject(object as AnyObject, forKey: key as AnyObject)
        }
        let url = URL(fileURLWithPath: URLEncodedFilenameFromString(key))
        do {
            try object.write(to: url, options: NSData.WritingOptions.completeFileProtection)
        } catch {
            print("Cannot write files to path \(url) ")
        }
    }
    
    private func setCodableObject(object: Any, key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: object)
        setData(data: data, key: key, useMemoryCache: false)
        
        memoryCache.setObject(object as AnyObject, forKey: key as AnyObject)
    }
    
    private func setData(data: Data, key: String, useMemoryCache: Bool) {
        if useMemoryCache {
            memoryCache.setObject(data as AnyObject, forKey: key as AnyObject)
        }
        setWritableObject(object: data, key: key, useMemoryCache: false)
    }
    
    //MARK: - Getters
    open func objectForKey(_ key: String) -> Any? {
        if let object = memoryCache.object(forKey: key as AnyObject){
            return object
        }
        if let object = NSKeyedUnarchiver.unarchiveObject(withFile: self.URLEncodedFilenameFromString(key)){
            memoryCache.setObject(object as AnyObject, forKey: key as AnyObject)
            return object
        }
        if let object =  dataForKey(key, useMemoryCache: false) {
            memoryCache.setObject(object as AnyObject, forKey: key as AnyObject)
            return object
        }
        return nil
    }
    
    open func imageForKey(_ key: String) -> UIImage? {
        if let image = memoryCache.object(forKey: key as AnyObject) as? UIImage {
            return image
        }
        if let data = dataForKey(key, useMemoryCache: false) {
            if let image = UIImage(data: data) {
                if let savedScale = objectForKey(key.appending("_scale_")) as? NSNumber {
                    if let savedOrientation = objectForKey(key.appending("_orientation_")) as? NSNumber {
                        let scale = CGFloat(savedScale.floatValue)
                        let orientation = UIImageOrientation.init(rawValue: savedOrientation.intValue)
                        let finalImage = UIImage.init(cgImage: image.cgImage!, scale:scale, orientation: orientation!)
                        memoryCache.setObject(finalImage, forKey: key as AnyObject)
                        return finalImage
                    }
                }
            }
        }
        return nil
    }
    
    open func dataForKey(_ key: String, useMemoryCache: Bool) -> Data? {
        if useMemoryCache {
            if let data = memoryCache.object(forKey: key as AnyObject) as? Data{
                return data
            }
            do {
                 let data = try Data(contentsOf: URL(fileURLWithPath: URLEncodedFilenameFromString(key)))
                if useMemoryCache {
                    memoryCache.setObject(data as AnyObject, forKey: key as AnyObject)
                }
                return data
            } catch  {
                
            }
        }
        return nil
    }
    
    //MARK: - Setters
    open func setObject(_ object: Any?, forKey key: String) {
        if let data = object {
            if self.persistent {
                if let objectData = data as? Data {
                    setWritableObject(object: objectData, key: key, useMemoryCache: true)
                }
                if let _ = object.self as? NSCoding {
                    setCodableObject(object: data, key: key)
                } else {
                    QK.Log("QKCache: Error! Object: \(object) is not supported for persistent caching! Object only cached in memory.")
                    memoryCache.setObject(object as AnyObject, forKey: key as AnyObject)
                }
                
                
            } else {
                memoryCache .setObject(object as AnyObject, forKey: key as AnyObject)
            }
        } else {
            deleteObjectForKey(key: key)
        }
    }
    
    open func setImage(_ image: UIImage, forKey key:String) {
        memoryCache.setObject(image, forKey: key as AnyObject)
        if self.persistent {
            setObject(NSNumber(value: Float(image.scale))  as AnyObject?, forKey: key.appending("_scale_"))
            setObject(NSNumber(value:image.imageOrientation.rawValue) as AnyObject?, forKey: key.appending("_orientation_"))
            if let data = UIImagePNGRepresentation(image) {
                setWritableObject(object: data, key: key, useMemoryCache: false)
            }
        }
    }
    
    open func setData(_ data: Data, forKey key: String) {
        setData(data: data, key: key, useMemoryCache: true)
    }
}
