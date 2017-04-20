//
//  QKUserManager.swift
//  SwiftCore
//
//  Created by Quang Co on 3/17/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

open class QKUserManager: NSObject {
    //This should be used as a Singletion solely
    private override init() {}
    
    private let kUserType = "user"
    private let kUserTokenKey = "$2y$10$JebsikhcX8j6wwX3agk12O1usfz6y7avRnwZ9qF31vLoN1Ob6HCcK"
    
    open static let userManager: QKUserManager = QKUserManager()
    
    open var token: String? {
        get {
            return UserDefaults.standard.string(forKey: kUserTokenKey)
        }
        
        set {
            if let newToken = newValue {
                UserDefaults.standard.set(newToken, forKey: kUserTokenKey)
            } else {
                UserDefaults.standard.removeObject(forKey: kUserTokenKey)
            }
            UserDefaults.standard.synchronize()
        }
    }
    
    open var isLoggedIn: Bool{
        get {
            return self.currentUser != nil && self.token != nil
        }
    }
    
    private var privateUser: QKUser?
    
    open var currentUser: QKUser? {
        get {
            if let user = self.privateUser {
                return user
            }
            if let user = NSKeyedUnarchiver.unarchiveObject(withFile: self.pathForObjectType(kUserType)) as? QKUser {
                return user
            }
            return nil
        }
        
        set {
            if let value = newValue {
                self.privateUser = value
                
                saveCurrentUser()
            } else {
                QK.Log("Use log out function instead of setting nil user")
            }
            
            
        }
    }
    
    
    open func saveCurrentUser() {
        if let user = self.privateUser {
            let path = self.pathForObjectType(kUserType)
            NSKeyedArchiver.archiveRootObject(user, toFile: path)
        } else {
            QK.Log("You cannot save nil user")
        }
    }
    
    open func logOutCurrentUser() {
        do {
            try FileManager.default.removeItem(atPath: self.pathForObjectType(kUserType))
        } catch {
            QK.Log("You dont have any saved user info")
        }
        self.token = nil
        self.privateUser = nil
    }
    
    
    
    private func pathForObjectType(_ type: String) -> String{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return "\(documentsPath)/\(type).bin"
    }
    
    
    open override var description: String {
        return "Token: \(token) \n User: \(currentUser)"
    }

}
