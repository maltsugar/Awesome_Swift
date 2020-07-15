//
//  AWLoginViewController.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/9.
//  Copyright © 2020 zgy. All rights reserved.
//

import UIKit

class AWLoginViewController: AWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
    }
    
    
    @IBAction func handleLoginAction() {
        AppTools.shared.afterLoginSucceed()
    }
    
    @IBAction func handleURLAction() {
    }
    
}

