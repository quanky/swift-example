//
//  SFSRequestManager.swift
//  swift3-example
//
//  Created by Quang Co on 4/11/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class SFSRequestManager: NSObject {
    static let sharedManager = SFSRequestManager()
    
    internal func sendExtensionRequest(_ cmd: String, _ param: SFSObject) {
        if let instance = SFSManager.gameManager.gameInstance {
            if SFSManager.gameManager.isConnected {
                if let request = ExtensionRequest.request(withExtCmd: cmd, params: param) as? IRequest {
                    instance.send(request)
                }
            } else {
                print("Not connected")
                SFSManager.gameManager.connect()
            }
            
            
        }
    }
    
    func sendInviteRequest(_ userID: Int) {
        
    }
    
    func sendStartGameRequest(_ invites: [Int], gemFee: Int = 5, coinFee: Int = 5) {
        let params = SFSObject()
        params.putBool("pvp", value: true)
        params.putInt("gemFee", value: gemFee)
        params.putIntArray("inviteList", value: invites)
        params.putInt("coinFee", value: coinFee)
        sendExtensionRequest(GameCommands.START_GAME.rawValue, params)
        
        print("Going to send lít \(invites)")
    }
}
