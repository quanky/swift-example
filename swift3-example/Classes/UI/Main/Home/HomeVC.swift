

//
//  HomeVC.swift
//  swift3-example
//
//  Created by Quang Co on 3/21/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

enum HomeSection: Int {
    case GeneralInfo = 0
    case TabOption = 1
}

enum StatSection: Int {
    case UserStatus = 2
    case OverallRank = 3
    case OtherStats = 4
}

enum MessageSection: Int {
    case NewChat = 2
    case Messages = 3
}

enum TabOption {
    case Stats
    case Messages
}

class HomeVC: QKViewController, UITableViewDelegate, UITableViewDataSource {
    
    var currentTabOption: TabOption = .Stats

    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tblView.register(UINib.init(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "EmptyTableViewCell")
        tblView.register(UINib.init(nibName: "HomeGeneralCell", bundle: nil), forCellReuseIdentifier: "HomeGeneralCell")
        tblView.register(UINib.init(nibName: "HomeTabsCell", bundle: nil), forCellReuseIdentifier: "HomeTabsCell")
        tblView.register(UINib.init(nibName: "HomeStatusCell", bundle: nil), forCellReuseIdentifier: "HomeStatusCell")
        tblView.register(UINib.init(nibName: "HomeOverallRankCell", bundle: nil), forCellReuseIdentifier: "HomeOverallRankCell")
        tblView.register(UINib.init(nibName: "HomeOtherStatsCell", bundle: nil), forCellReuseIdentifier: "HomeOtherStatsCell")
        
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.estimatedRowHeight = 100.0
        tblView.dataSource = self
        tblView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : Table View Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sectionVal = HomeSection(rawValue: section) {
            switch sectionVal {
            case .GeneralInfo:
                return 1
            case .TabOption:
                return 1
            }
        }
        if self.currentTabOption == .Stats {
            if let sectionVal = StatSection(rawValue: section) {
                switch sectionVal {
                case .UserStatus:
                    return 1
                case .OverallRank:
                    return 1
                case .OtherStats:
                    return 1
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.section
        if let sectionVal = HomeSection(rawValue: section) {
            switch sectionVal {
            case .GeneralInfo:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeGeneralCell", for: indexPath) as? HomeGeneralCell {
                    cell.populateData()
                    return cell
                }
                break
            case .TabOption:
                if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTabsCell", for: indexPath) as? HomeTabsCell {
                    return cell
                }
                
                break
                
            }
        }
        if self.currentTabOption == .Stats {
            if let sectionVal = StatSection(rawValue: section) {
                switch sectionVal {
                case .UserStatus:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeStatusCell", for: indexPath) as? HomeStatusCell {
                        return cell
                    }
                    break
                case .OverallRank:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeOverallRankCell", for: indexPath) as? HomeOverallRankCell {
                        cell.lblValue.text = "0 of 233"
                        return cell
                    }
                    break
                case .OtherStats:
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "HomeOtherStatsCell", for: indexPath) as? HomeOtherStatsCell {
                        cell.index = row
                        cell.populateData()
                        return cell
                    }
                    break
                }
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyTableViewCell", for: indexPath)
        return cell
    }

}
