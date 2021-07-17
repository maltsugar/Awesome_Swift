//
//  AWNavigationController.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/24.
//  Copyright © 2020 zgy. All rights reserved.
//

// 系统的导航，做样式统一定制
import UIKit

let kAWNavBackImgName = "navigationbar_back"
let kAWBackIndicatorImage = "navi_back"
let kAWNavBackEdge = UIEdgeInsets(top: 0, left: -15, bottom: 0, right: 15)

/**
        两种自定义导航的方式（1.更换整个返回按钮 2.只更换返回指示器），都要保证侧滑手势有效
       ✨✨✨✨✨使用其中一种，解注释即可✨✨✨✨✨
 */


//  1. 整个替换导航返回按钮image
class AWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 导航
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = .red
        let dict = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.titleTextAttributes = dict
        
        // 设置整个项目所有item的主题样式
        let item = UIBarButtonItem.appearance()
        
        // 设置普通状态
        let font = UIFont.systemFont(ofSize: 17)
        let normalAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: font
        ]
        item.setTitleTextAttributes(normalAttr, for: .normal)
        
        
        // 设置不可用状态
        let disableAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: font
        ]
        item.setTitleTextAttributes(disableAttr, for: .disabled)
        
  
        // 设置导航阴影，去掉原有的阴影线条
        navBar.setBackgroundImage(UIImage.jk_image(with: UIColor.orange), for: .any, barMetrics: .default)
        navBar.shadowImage = UIImage.jk_image(with: UIColor.lightGray)

        
        
        self.interactivePopGestureRecognizer?.delegate = self
        self.delegate = self
    }
    
    @objc func back() {
        self.popViewController(animated: true)
    }
    
    
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
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(target: self, action: #selector(back), image: kAWNavBackImgName, highImage: kAWNavBackImgName, imageEdgeInsets: kAWNavBackEdge)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        if (viewControllers.count > 0) {
            var i = 0
            for vc in viewControllers {
                if (i > 0) {
                    vc.navigationItem.leftBarButtonItem = UIBarButtonItem(target: self, action: #selector(back), image: kAWNavBackImgName, highImage: kAWNavBackImgName, imageEdgeInsets: kAWNavBackEdge)
                    vc.hidesBottomBarWhenPushed = true
                }
                i += 1
            }
        }
        super.setViewControllers(viewControllers, animated: animated)
    }

}

extension AWNavigationController: UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.interactivePopGestureRecognizer?.isEnabled = true
    }
}

 


//  <====================================================================================>


/**
// 2. 只替换返回箭头 backIndicatorImage backIndicatorTransitionMaskImage
class AWNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 导航
        let navBar = UINavigationBar.appearance()
        navBar.barTintColor = .red
        let dict = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.titleTextAttributes = dict
        
        // 设置整个项目所有item的主题样式
        let item = UIBarButtonItem.appearance()
        
        // 设置普通状态
        let font = UIFont.systemFont(ofSize: 17)
        let normalAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: font
        ]
        item.setTitleTextAttributes(normalAttr, for: .normal)
        
        
        // 设置不可用状态
        let disableAttr = [
            NSAttributedString.Key.foregroundColor: UIColor.lightGray,
            NSAttributedString.Key.font: font
        ]
        item.setTitleTextAttributes(disableAttr, for: .disabled)
        
        // 返回按钮
        // 设置文字，水平偏移到看不见的位置
        item.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -9999, vertical: 0), for: .default)
    
        
        
        // 设置导航阴影，去掉原有的阴影线条
        navBar.setBackgroundImage(UIImage.jk_image(with: UIColor.orange), for: .any, barMetrics: .default)
        navBar.shadowImage = UIImage.jk_image(with: UIColor.lightGray)
        
        
        
        
        self.navigationBar.backIndicatorImage = UIImage(named: kAWBackIndicatorImage)?.withRenderingMode(.alwaysOriginal)
        self.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: kAWBackIndicatorImage)?.withRenderingMode(.alwaysOriginal)
        
    }
    
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
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.viewControllers.count > 0) {
            // 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
            viewController.hidesBottomBarWhenPushed = true
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
*/
