//
//  AppDelegate.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/2.
//  Copyright © 2020 zgy. All rights reserved.
//

import UIKit


/**
⚠️⚠️⚠️⚠️⚠️⚠️⚠️
   ⚠️⚠️⚠️⚠️
    ⚠️⚠️⚠️
     ⚠️⚠️
      ⚠️
⚠️⚠️⚠️⚠️⚠️⚠️推荐所有的VC继承  AWBaseViewController  ，便于统一修改导航样式
继承  AWBaseViewController
继承  AWBaseViewController
继承  AWBaseViewController

*/


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        // 设置根视图
        AppTools.shared.startApp()
        
        return true
    }



}

