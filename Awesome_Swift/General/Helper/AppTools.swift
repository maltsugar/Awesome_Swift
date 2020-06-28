//
//  AppTools.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/23.
//  Copyright © 2020 zgy. All rights reserved.
//

import Foundation

class AppTools {
    static let shared = AppTools()
    private init() {}
    // =================
    
    let dateFmtter = DateFormatter()
    let tabBarController = AWTabBarController()
//    let loginNav =
    
    
    
    
    
    func startApp(loginVC: Bool = false) {
        guard let window = kAppDelegate?.window else {
            return
        }
        
        if (loginVC) {
            
        }else {
            window?.rootViewController = self.tabBarController
        }
    }
    
}
