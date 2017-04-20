//
//  GameManager.swift
//  swift3-example
//
//  Created by Quang Co on 4/11/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class GameManager: NSObject {
    static let gameManager = GameManager()
    
    internal var listUserOnline: [SFSPlayerModel] = []
    
    func getListOnline() -> [SFSPlayerModel] {
        return listUserOnline
    }
    
    func resetListOnline() {
        listUserOnline.removeAll()
    }
    
    func updateListOnline(_ list: [SFSPlayerModel]) {
        listUserOnline = list 
    }
    
}
