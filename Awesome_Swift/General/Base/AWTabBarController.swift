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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupChildViewControllers()
    
    }
    
    func setupChildViewControllers() {
        let vc0 = DemoViewController0()
        self.setupChildVC(childVC: vc0, title: "首页", image: "tabbar_0", selectedImage: "tabbar_0hl")
        
        let vc1 = DemoViewController1()
        self.setupChildVC(childVC: vc1, title: "更多", image: "tabbar_1", selectedImage: "tabbar_1hl")
//        vc1.view.showEmptyView()
        
        let vc2 = DemoViewController2()
        self.setupChildVC(childVC: vc2, title: "我的", image: "tabbar_2", selectedImage: "tabbar_2hl")
        
        let temp = [vc0, vc1, vc2]
        var navArr = [AWRootNavigationController]()
        
        for vc in temp {
            let nav = AWRootNavigationController(rootViewController: vc)
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
    
}
