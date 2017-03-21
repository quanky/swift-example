//
//  AccountManager.swift
//  swift3-example
//
//  Created by Quang Co on 3/21/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit
import SwiftCore

class AccountManager: QKUserManager {
    
}

extension QKUserManager {
    func getCurrentAccount() -> AccountModel? {
        if let user = currentUser as? AccountModel {
            return user
        }
        return nil
    }
    
    func setCurrentAccount(_ account: AccountModel){
        self.currentUser = account
    }
}
