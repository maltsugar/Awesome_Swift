//
//  AWTabBarController.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/23.
//  Copyright © 2020 zgy. All rights reserved.
//

import UIKit

class AWTabBarController: UITabBarController {
    fileprivate let normalColor = kRGBAColor(123, 123, 123)
    fileprivate let selectedColor = kHexAColor(0x26ab28)
    
    override var selectedIndex: Int {
        set {
            var flag = true // 未登录情况不允许选定指定的index
            if (newValue == 2) {
//                flag = AWUserManager.shared().isUserLogined()
                flag = false
                AppTools.shared.forceLogin(animated: true)
            }
            
            if (flag) {
                super.selectedIndex = newValue
            }
            
        }
        get {
            return super.selectedIndex
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChildViewControllers()
    
    }
    
    func setupChildViewControllers() {
        let vc0 = DemoViewController0()
        self.setupChildVC(childVC: vc0, title: "首页", image: "tabbar_0", selectedImage: "tabbar_0hl")
        
        let vc1 = DemoViewController1()
        self.setupChildVC(childVC: vc1, title: "更多", image: "tabbar_1", selectedImage: "tabbar_1hl")
  
        
        let vc2 = DemoViewController2()
        self.setupChildVC(childVC: vc2, title: "我的", image: "tabbar_2", selectedImage: "tabbar_2hl")
        
        let temp = [vc0, vc1, vc2]
        var navArr = [AWContainerNavigationController]()
        
        for vc in temp {
            let nav = AWContainerNavigationController(rootViewController: vc)
            navArr.append(nav)
        }
        
        self.setViewControllers(navArr, animated: false)
        
        
        self.delegate = self
        
        UITabBar.appearance().tintColor = selectedColor
        if #available(iOS 11.0, *) {
            UITabBar.appearance().unselectedItemTintColor = normalColor
        }
        
        // 去掉tabbar上方线
        self.tabBar.shadowImage = UIImage.jk_image(with: kHexAColor(0x999999))
        self.tabBar.backgroundImage = UIImage.jk_image(with: .white)
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -2)
    }
    
    func setupChildVC(childVC: UIViewController, title: String, image: String, selectedImage: String) {
        // 设置子控制器的文字
        childVC.title = title;// 同时设置tabbar和navigationBar的文字
        // 设置子控制器的图片
        childVC.tabBarItem.image = kImageNamed(image)
        childVC.tabBarItem.selectedImage = kImageNamed(selectedImage).withRenderingMode(.alwaysOriginal)
        // 设置文字的样式
        let textAttrs = [NSAttributedString.Key.foregroundColor: normalColor]
        let selectTextAttrs = [NSAttributedString.Key.foregroundColor: selectedColor]
        childVC.tabBarItem.setTitleTextAttributes(textAttrs, for: .normal)
        childVC.tabBarItem.setTitleTextAttributes(selectTextAttrs, for: .selected)
    }
    

    


}

//MARK:- UITabBarControllerDelegate
extension AWTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        var flag = true
        if let idx = tabBarController.viewControllers?.firstIndex(of: viewController) {
//            if (idx == 1) {
//                // 仿微博，选指定的index,直接模态一个新vc
//                let vc = UIViewController()
//                vc.view.backgroundColor = .orange
//                let nav = AWContainerNavigationController(rootViewController: vc)
//                nav.modalPresentationStyle = .fullScreen
//                self.present(nav, animated: true, completion: nil)
//                return false
//            }
            
            
            if (idx == 2) {
                // 指定的index 需要校验登录状态
                flag = AWUserManager.shared.isUserLogined()
                flag = false
                AppTools.shared.forceLogin(animated: true)
            }
        }
        return flag
    }
}
