//
//  LaunchVC.swift
//  swift3-example
//
//  Created by Quang Co on 3/17/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class LaunchVC: QKViewController, SFSManagerDelegate {
    
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var btnReload: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.globalColor()
        _ = SFSManager.gameManager
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if AccountManager.userManager.isLoggedIn {
//            //User logged in before, should show main view
//            appDelegate?.showMainView()
//        } else {
//            //Show login or sign up view
//            appDelegate?.showLoginView()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    @IBAction func btnReloadClicked() {
        if !SFSManager.gameManager.isConnected {
            SFSManager.gameManager.connect()
            lblMessage.text = "Connecting to server"
            self.btnReload.isHidden = true
        }
    }
    
    //MARK: - SFS Delegate
    func didFailToConnect(error: NSError) {
        self.lblMessage.text = error.localizedDescription
        self.btnReload.isHidden = false
    }
}
