//
//  AWRootNavigationController.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/24.
//  Copyright © 2020 zgy. All rights reserved.
//

import UIKit

class AWRootNavigationController: RTRootNavigationController {

    override var childForStatusBarStyle: UIViewController? {
        get {
            return self.visibleViewController
        }
    }
    
    override var childForStatusBarHidden: UIViewController? {
        get {
            return self.visibleViewController
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.useSystemBackBarButtonItem = true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if (viewControllers.count > 0) {
            var i = 0
            for vc in viewControllers {
                if (i > 0) {
                    vc.hidesBottomBarWhenPushed = true
                }
                i += 1
            }
        }
        super.setViewControllers(viewControllers, animated: animated)
    }

}
