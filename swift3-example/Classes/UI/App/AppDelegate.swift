//
//  AppDelegate.swift
//  swift3-example
//
//  Created by Quang Co on 3/17/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit
import SwiftCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

//MARK : - Custom Tools
extension AppDelegate {
    func loginWithAccount(_ account: AccountModel) {
        AccountManager.userManager.setCurrentAccount(account)
        AccountManager.userManager.token = account.token
        AccountManager.userManager.saveCurrentUser()
        QKCache.defaultCache.setObject(account.token, forKey: AppConstants.Cache.APIToken)
        subscribeToPushNotification()
        DispatchQueue.global().async {
            //Should refresh user profile or portfolio here
        }
        showMainView()
    }
    
    func logOut() {
        unsubscribeToPushNotification()
        AccountManager.userManager.logOutCurrentUser()
        QKCache.cacheWithID(cacheID: AppConstants.Cache.APIToken)?.clearAllData()
    }
    
    func showLoginView() {
        let vc = UIStoryboard(name: AppConstants.InterfaceID.LoginSb, bundle: nil).instantiateViewController(withIdentifier: AppConstants.InterfaceID.LoginVC)
        transitionToViewController(vc)
    }
    
    func showMainView() {
        let vc = UIStoryboard(name: AppConstants.InterfaceID.MainSb, bundle: nil).instantiateInitialViewController()
        transitionToViewController(vc)
    }
    
    func transitionToViewController(_ vc: UIViewController?, animated: Bool = true, options: UIViewAnimationOptions = .transitionFlipFromRight) {
        let _ = vc?.view
        
        if let vc = vc
        {
            if !animated {
                
                self.window?.rootViewController = vc
                
            } else {
                UIView.transition(with: UIApplication.shared.keyWindow!, duration: 1.0, options: options, animations: { () -> Void in
                    
                    self.window?.rootViewController = vc
                    
                }, completion: { (Bool) -> Void in
                    //Should validate token again in here
                    
                })
            }
        } else {
            QK.Log("Unabled to go transition to null view controller")
        }
    }
    
    func subscribeToPushNotification() {
        
    }
    
    func unsubscribeToPushNotification() {
        
    }
}



