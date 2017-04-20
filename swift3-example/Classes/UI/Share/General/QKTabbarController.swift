//
//  QKTabbarController.swift
//  swift3-example
//
//  Created by Quang Co on 3/17/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class QKTabbarController: UITabBarController, UITabBarControllerDelegate {
    
    var listItems  = [
        QKTabbarModel(title: "Home", icon: "home", index: 0),
        QKTabbarModel(title: "Setting", icon: "setting", index: 4),
        QKTabbarModel(title: "Battle", icon: "", index: 2),
        QKTabbarModel(title: "Graph", icon: "graph", index: 1),
        QKTabbarModel(title: "Showcase", icon: "showcase", index: 3),
    ]
    
    //Should store this tabbar for quick access
    class func globalTabbar() -> QKTabbarController? {
        
        return nil
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeTabbar()
    }
    
    //MARK : - Customization
    func customizeTabbar() {
        self.delegate = self
        UITabBar.appearance().backgroundColor = UIColor.globalColor()
        tabBar.backgroundColor = UIColor.globalColor()
        tabBar.backgroundImage = CommonUtility.imageWithColor(UIColor.globalColor(), size:tabBar.frame.size)
        
        let iconSize = CGSize(width: 24, height: 24)
        
        for model in listItems {
            if tabBar.items!.count > model.index, let item = tabBar.items?[model.index] {
                item.title = model.title
                item.image = CommonUtility.resizeImage(image: model.staticImage, size: iconSize)?.withRenderingMode(.alwaysOriginal)
                item.selectedImage = CommonUtility.resizeImage(image: model.activeImage, size: iconSize)?.withRenderingMode(.alwaysOriginal)
                item.setTitleTextAttributes([NSFontAttributeName:  UIFont.tabbarFont(), NSForegroundColorAttributeName: UIColor.tabbarSelectedColor()], for: .selected)
                item.setTitleTextAttributes([NSFontAttributeName:  UIFont.tabbarFont(), NSForegroundColorAttributeName: UIColor.white], for: .normal)
            }
        }
    }
    
    //MARK : - Delegate
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = (self.viewControllers! as NSArray).index(of: viewController)
        //User this function if you want to prevent user to view any child controller of tabbar base on their index
        //One example is anonymous login use shouldnt be able to get in setting view
        if !AccountManager.userManager.isLoggedIn {
            if index == 4 {
                //Show pop up that user cant enter this unless they login
                return false
            }
        }
        
        //You can also use this to perform some action instead of entering child controller
//        if index == 2 {
//            self.openWebview()
//            return false
//        }
        return true
    }
    
    //MARK : - Tools
    func openWebview() {
        
    }
    

}


class QKTabbarModel {
    var title: String = ""
    var icon: String = ""
    var index: Int = 0
    var activeImage: UIImage?
    var staticImage: UIImage?
    convenience init(title: String, icon: String, index: Int) {
        self.init()
        self.title = title
        self.icon = icon
        self.index = index
        activeImage = UIImage.init(named: "tab_\(icon)_active.png")
        staticImage = UIImage.init(named: "tab_\(icon)_static.png")
    }
}
