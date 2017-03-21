//
//  LoginVC.swift
//  swift3-example
//
//  Created by Quang Co on 3/21/17.
//  Copyright © 2017 quanky. All rights reserved.
//

import UIKit

class LoginVC: QKViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: - Actions
    @IBAction func btnLoginClicked() {
        let sample = AccountModel()
        sample.id = "123"
        sample.email = "qu4ngco@gmail.com"
        sample.token = "$2y$10$JebsikhcX8j6wwX3agk12O1usfz6y7avRnwZ9qF31vLoN1Ob6HCcK"
        appDelegate?.loginWithAccount(sample)
    }
    
    //MARK: - Misc
    
}
