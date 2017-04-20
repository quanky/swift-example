//
//  SFSAccountManager.swift
//  swift3-example
//
//  Created by Quang Co on 3/23/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class SFSAccountManager: NSObject {
    //This should be used as a Singletion solely
    private override init() {}
    
    private let kUserType = "user"
    private let kUserTokenKey = "$2y$10$JebsikhcX8j6wwX3agk12O1usfz6y7avRnwZ9qF31vLoN1Ob6HCcK"
    
    static let userManager: SFSAccountManager = SFSAccountManager()
    var isLoggedIn: Bool{
        get {
            return self.currentUser != nil && SFSManager.gameManager.isConnected
        }
    }
    
    private var privateUser: SFSAccountModel?
    
    var currentUser: SFSAccountModel? {
        get {
            if let user = self.privateUser {
                return user
            }
            if let user = NSKeyedUnarchiver.unarchiveObject(withFile: self.pathForObjectType(kUserType)) as? SFSAccountModel {
                return user
            }
            return nil
        }
        
        set {
            if let value = newValue {
                self.privateUser = value
//                self.token = value.sfsId
                saveCurrentUser()
            } else {
                QK.Log("Use log out function instead of setting nil user")
            }
            
            
        }
    }
    
    
    func saveCurrentUser() {
        if let user = self.privateUser {
            let path = self.pathForObjectType(kUserType)
            NSKeyedArchiver.archiveRootObject(user, toFile: path)
        } else {
            QK.Log("You cannot save nil user")
        }
    }
    
    func logOutCurrentUser() {
        do {
            try FileManager.default.removeItem(atPath: self.pathForObjectType(kUserType))
        } catch {
            QK.Log("You dont have any saved user info")
        }
//        self.token = nil
        self.privateUser = nil
    }
    
    
    
    private func pathForObjectType(_ type: String) -> String{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        return "\(documentsPath)/\(type).bin"
    }
    
    
    override var description: String {
        return "User: \(currentUser)"
    }
    
}
