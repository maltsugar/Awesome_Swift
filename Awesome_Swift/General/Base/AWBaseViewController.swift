//
//  AWBaseViewController.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/23.
//  Copyright © 2020 zgy. All rights reserved.
//

import UIKit


/**
使用RTRootNavigationController时，要使用BaseViewContrller 统一定制导航
*/
class AWBaseViewController: UIViewController {
    fileprivate let kAWNavBackImgName  = "navigationbar_back"
//    fileprivate let kAWNavBackImgName  = "navi_back"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 这里统一定制导航样式
        if let navBar = self.navigationController?.navigationBar {
            let dic = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navBar.barTintColor = UIColor.red
            navBar.tintColor = UIColor.white
            navBar.isTranslucent = true
            navBar.titleTextAttributes = dic
        }
        
    }
  
    
    override func rt_customBackItem(withTarget target: Any!, action: Selector!) -> UIBarButtonItem! {
//        let barBtnItem = UIBarButtonItem(title: NSLocalizedString("Back", comment: ""), style: .plain, target: target, action: action)
        let barBtnItem = UIBarButtonItem(image: kImageNamed(kAWNavBackImgName), style: .plain, target: target, action: action)
        return barBtnItem
    }
    
    

}
