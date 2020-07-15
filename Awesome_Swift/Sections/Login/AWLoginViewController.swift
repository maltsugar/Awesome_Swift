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
        //        AppTools.shared.afterLoginSucceed()
        
        
        let param = [
            kInterfaceActionKey: "ydCommanderReport.v1.common.codeloginDev",
            kInterfaceLoginOptionKey: true,
            "mobile":"29998862",
            "empCode":"29998862"
            ] as [String : Any]
        AWNetManager.post(param: param)
    }
    
    @IBAction func handleURLAction() {
    }
    
}

