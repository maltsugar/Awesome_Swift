//
//  AWChangeURLViewController.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/16.
//  Copyright © 2020 zgy. All rights reserved.
//  该VC只在DEBUG出现，且确定按钮只在DEBUG模式生效

import UIKit

class AWChangeURLViewController: AWBaseViewController {
    
    @IBOutlet weak var baseURLTF: UITextField!
    @IBOutlet weak var pathTF: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let configMgr = AWConfigManager.shared
        baseURLTF.text = configMgr.baseURL
        pathTF.text = configMgr.path
        
    }
    
    @IBAction func handleCloseAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleConfirmAction() {
        #if DEBUG
        let configMgr = AWConfigManager.shared
        configMgr.baseURL = baseURLTF.text
        configMgr.path = pathTF.text
        #endif
        
        handleCloseAction()
    }
    
}
