//
//  BattleVC.swift
//  swift3-example
//
//  Created by Quang Co on 4/11/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class BattleVC: QKViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tblInvite: UITableView!
    
    var listUser: [SFSPlayerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblInvite.register(UINib.init(nibName: "BattleInviteCell", bundle: nil), forCellReuseIdentifier: "BattleInviteCell")
        
//        tblInvite.rowHeight = UITableViewAutomaticDimension
//        tblInvite.estimatedRowHeight = 100.0
        tblInvite.dataSource = self
        tblInvite.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.listUser = GameManager.gameManager.getListOnline().filter({ (item) -> Bool in
            item.battletag != SFSAccountManager.userManager.currentUser?.battletag
        })
        tblInvite.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    // MARK: - Navigation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BattleInviteCell", for: indexPath) as? BattleInviteCell {
            let item = listUser[indexPath.row]
            cell.lblName.text = item.display
            cell.lblTag.text = item.battletag
            cell.playerData = item
            return cell
        }
        return UITableViewCell()
    }


}
