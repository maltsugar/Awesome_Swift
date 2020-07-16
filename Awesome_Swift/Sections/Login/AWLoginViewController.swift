//
//  AWLoginViewController.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/9.
//  Copyright © 2020 zgy. All rights reserved.
//

import UIKit

class AWLoginViewController: AWBaseViewController {
    
    @IBOutlet weak var testView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        
        testView.setCorners([.topRight, .bottomLeft, .bottomRight], radius: 10)
        
        testView.addShadow(ofColor: .brown, radius: 10, offset: CGSize(width: 10, height: 50), opacity: 1)
    }
    
    
    @IBAction func handleLoginAction() {
                AppTools.shared.afterLoginSucceed()
        
        
//        let param = [
//            kInterfaceActionKey: "xxxxxxx.action",
//            kInterfaceLoginOptionKey: true,
//            "mobile":"xxxx",
//            "empCode":"xxxx"
//            ] as [String : Any]
//        AWNetManager.post(path: nil, param: param) { (res) in
//            printLog(res)
//        }
    }
    
    @IBAction func handleURLAction() {
        let vc = AWChangeURLViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}

