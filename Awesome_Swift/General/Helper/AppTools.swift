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
    
    // 推荐用rootVC 显示登录页或者tabbarcontroller
    private var rootBaseVC = UIViewController()
    private lazy var rootVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        rootBaseVC.view.backgroundColor = .white
        vc.addChild(rootBaseVC)
        rootBaseVC.view.frame = vc.view.bounds
        vc.view.addSubview(rootBaseVC.view)
        
        return vc
    }()
    
    
    
    private lazy var tabBarController: AWTabBarController = {
        let tab = AWTabBarController()
        return tab
    }()
    private lazy var loginNav: AWRootNavigationController = {
        let loginVC = AWLoginViewController()
        let loginNav = AWRootNavigationController(rootViewController: loginVC)
        return loginNav
    }()
    
    
    
    
    
    func startApp(loginVC: Bool = false) {
        guard let window = kAppDelegate?.window else {
            return
        }
        
        
        window?.rootViewController = rootVC
        
        if (loginVC) {
            setDisplayVC(vc: self.loginNav)
        }else {
            setDisplayVC(vc: self.tabBarController)
        }
    }
    
    private func setDisplayVC(vc: UIViewController?) {
        if let _vc = vc {
            self.rootVC.addChild(_vc)
            self.rootVC.view.addSubview(_vc.view)
            _vc.view.snp.makeConstraints { (make) in
                make.edges.equalTo(0)
            }
            
//            self.rootVC.addChild(_vc)
//            self.rootVC.view.addSubview(_vc.view)
//            self.tabBarController.view.snp.makeConstraints { (make) in
//                make.edges.equalTo(0)
//            }
//            self.rootVC.transition(from: self.rootBaseVC, to: _vc, duration: 0.5, options: .transitionFlipFromBottom, animations: nil, completion: nil)
        }
    }
    
    private func removeDisplayVC(vc: UIViewController?) {
        if let _vc = vc {
            _vc.removeFromParent()
            _vc.view.removeFromSuperview()
        }
    }
    
    
    
    
}
