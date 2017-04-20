//
//  SFSManager.swift
//  swift3-example
//
//  Created by Quang Co on 3/23/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit
@objc protocol SFSManagerDelegate : class {
    @objc optional func didFailToConnect(error: NSError)
    
}

class SFSManager: NSObject, ISFSEvents {
    
    static let gameManager = SFSManager()
    
    var gameInstance: SmartFox2XClient!
    var delegate: SFSManagerDelegate?
    
    var isConnected: Bool {
        get {
            return gameInstance.isConnected
        }
    }
    
    
    override init() {
        super.init()
        gameInstance = SmartFox2XClient(smartFoxWithDebugMode: false, delegate: self)
        gameInstance.loadConfig("SFSConfig.xml", connectOnSuccess: true)
    }
    
    //MARK : - API Actions
    
    func connect() {
        print("trying to connect")
        gameInstance.connect()
    }
    
    func login() {
        let params = SFSObject()
        params.putUtfString("did", value: getDeviceId())
        let request = LoginRequest(userName: "", password: "", zoneName: "", params: params)
        gameInstance.send(request)
    }
    
    //MARK : - Event handlers
    internal func onConnection(_ evt: SFSEvent!) {
        if let response = evt.params{
            if let error = response["errorMessage"] as? NSError {
                self.delegate?.didFailToConnect?(error: error)
            } else if let success = response["success"] as? Bool, success == true{
                self.login()
            }
        }
        
        
    }
    
    internal func onConnectionLost(_ evt: SFSEvent!) {
        print("Connection lost")
    }
    
    internal func onLogin(_ evt: SFSEvent!) {
        print("Logined")
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate?.showMainView()
    }
    
    func onLogout(_ evt: SFSEvent!) {
        print("Logout")
    }
    
    func onRoomJoin(_ evt: SFSEvent!) {
        print("Joined Room")
    }
    
    func onLoginError(_ evt: SFSEvent!) {
        print("Login error")
    }
    
    func onRoomRemove(_ evt: SFSEvent!) {
        print("Room removed")
    }
    
    internal func onExtensionResponse(_ evt: SFSEvent!) {
        
        if let response = evt.params {
            if let cmd = response["cmd"] as? String, let command = GameCommands(rawValue: cmd), let info =  response["params"] as? SFSObject {
                self.handleExtensionReponses(cmd: command, rs: info)
            } else if let cmd = response["cmd"] as? String {
                print("Received unrecognied command \(cmd)")
            } else {
                print("Receive response without command! \(response)")
            }
        } else {
            print("Received unwanted response \(evt)")
        }
    }
    
    //MARK: - Handler extension response
    func handleExtensionReponses(cmd: GameCommands, rs: SFSObject) {
//        print("Received command \(cmd)")
        
        switch cmd {
        case .JOIN_ZONE:
            let account = SFSAccountModel(sfsObject: rs)
            SFSAccountManager.userManager.currentUser = account
        case .LIST_USER_ONLINE:
            if let list: SFSArray = rs.getSFSArray("lFound") as? SFSArray {
                var listPlayer:[SFSPlayerModel] = []
                for index in 0..<list.size() {
                    if let item = list.getSFSObject(index) as? SFSObject {
                        let player = SFSPlayerModel(sfsObject: item)
                        listPlayer.append(player)
                    }
                }
                GameManager.gameManager.updateListOnline(listPlayer)
            }
        default:
            print("Rêcive cmd \(cmd)")
            break
        }
    }
    
    func updateDelegate(_ receiver: SFSManagerDelegate?) {
        self.delegate = receiver
    }
    
    func getDeviceId() -> String {
        if let id = UIDevice.current.identifierForVendor?.uuidString {
            return id
        }
        return "QUANGTESTINGUDID"
    }
    
    
    
    
    
}
