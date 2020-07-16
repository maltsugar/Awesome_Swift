//
//  AppTools.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/23.
//  Copyright © 2020 zgy. All rights reserved.
//

import Foundation



// 清除类型
enum AWClearType {
    case all
    case onlyMemory
}

enum AWLoginPresentType {
    /// 不弹任何页面
    case none
    
    /// 弹出登录页面
    case loginVC
    
    /// 弹出登录页，并且销毁TabbarController(重登录之后，刷新所有vc)
    case loginVCAndDestoryTabbarVC
}


class AppTools {
    static let shared = AppTools()
    private init() {}
    // =================
    
    //MARK:- properties
    let dateFmtter = DateFormatter()
    var loginSucceedClosure: (() -> Void)?
    var logoutSucceedClosure: (() -> Void)?
    var introductionView: GYIntroductionView?
    
    // 推荐用rootVC 显示登录页或者tabbarcontroller
    private var _loginNav: AWRootNavigationController?
    private var _didShowLoginVC = false // 当前已经弹出登录页面
    private var _tabBarController: AWTabBarController?
    
    private lazy var rootVC: UIViewController = {
        let vc = UIViewController()
        vc.view.backgroundColor = .white
        return vc
    }()
    
    
    // OC式懒加载
    private var tabBarController: AWTabBarController? {
        get {
            if (nil == _tabBarController) {
                _tabBarController = AWTabBarController()
                _tabBarController?.modalPresentationStyle = .fullScreen
            }
            return _tabBarController
        }
        set {
            _tabBarController = newValue
        }
    }
    private var loginNav: AWRootNavigationController? {
        get {
            if (nil == _loginNav) {
                let loginVC = AWLoginViewController()
                _loginNav = AWRootNavigationController(rootViewController: loginVC)
                _loginNav?.modalPresentationStyle = .fullScreen
            }
            return _loginNav
        }
        set {
            _loginNav = newValue
        }
    }
    
    
    
    //MARK:- functions
    func startApp(loginVC: Bool = false) {
        guard let window = kAppDelegate?.window else {
            return
        }
        
        
        window?.rootViewController = rootVC
        
        if (loginVC) {
            setDisplayVC(vc: loginNav)
        }else {
            setDisplayVC(vc: tabBarController)
        }
        
        // 配置请求类，采用AWConfigManager不用宏 可以动态设置URL，便于调试
        // 调用该方法会调用内部setup方法，设置通用配置
        _ = AWConfigManager.shared
        
        // 设置键盘
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        
        // 版本引导页，并不是每个小版本都显示，具体控制由下面注释处3行代码控制
        if let _lastIntrolVersion = kUserDefaults.object(forKey: kLastShowIntrolductionVersionKey) as? String {
            // 默认不显示引导页，直接执行下面3行代码
            // 需要显示引导页，注释下面3行代码
            let curVersion = kAppVersion()
            kUserDefaults.set(curVersion, forKey: kLastShowIntrolductionVersionKey)
            kUserDefaults.synchronize()
            
            
            
            if _lastIntrolVersion != kAppVersion() {
                // 引导页结束后， 同步当前版本号到kLastShowIntrolductionVersionKey
                showIntrolductionPages()
            }
        }else {
            // 引导页结束后， 同步当前版本号到kLastShowIntrolductionVersionKey
            showIntrolductionPages()
        }
        
        
    }
    
    func afterLoginSucceed() {
        // 保存用户id token 等
        AWUserManager.shared.saveUserInfo()
        
        self.dismissLoginVC()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ) {
            self.setDisplayVC(vc: self.tabBarController)
        }
        
        loginSucceedClosure?()
        
    }
    
    func dismissLoginVC() {
        removeDisplayVC(vc: self.loginNav, animated: true)
        self.loginNav = nil
        _didShowLoginVC = false
    }
    
    func forceLogin(animated: Bool, removeTabbarController: Bool = false) {
        // 获取用户信息的标记
        let didCacheUserInfo = AWUserManager.shared.isUserLogined()
        
        if !didCacheUserInfo, !_didShowLoginVC {
            // 没有获取本地存储的 用户id 用户token
            
            setDisplayVC(vc: self.loginNav, animated: animated)
            _didShowLoginVC = true
            if removeTabbarController {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    // 登录后需要刷新的话， 移除tabbarController
                    self.removeDisplayVC(vc: self.tabBarController)
                    self.tabBarController = nil
                }
            }
        }
        
    }
    
    func logout(tip: String?, clearType: AWClearType = .all, presentType: AWLoginPresentType = .none) {
        // 清空用户id token等
        
        AWUserManager.shared.clearUserInfo() // 根据clearType 清除信息
        
        tabBarController?.selectedIndex = 0;
        
        if let _tip = tip, _tip.count > 0 {
            if let window = try? mainWindow() {
                window.jk_makeToast(_tip, duration: 0.5, position: JKToastPositionCenter)
            }
        }
        
        if presentType == .loginVCAndDestoryTabbarVC {
            forceLogin(animated: true, removeTabbarController: true)
        }else if presentType == .loginVC {
            forceLogin(animated: true, removeTabbarController: false)
        }
        
        logoutSucceedClosure?()
    }
    
    func showIntrolductionPages() {
        if let window = try? mainWindow() {
            let imgNames = ["img_index_01bg", "img_index_02bg", "img_index_03bg"]
            let introductionView = GYIntroductionView(imgNames: imgNames, bgImgNames: nil)
            self.introductionView = introductionView
            window.addSubview(introductionView!)
            
            
            let enterButton = UIButton(type: .custom)
            enterButton.backgroundColor = .orange
            enterButton.setTitle("立即进入", for: .normal)
            enterButton.bounds = CGRect(x: 0, y: 0, width: 200, height: 60)
            enterButton.center = CGPoint(x: kScreenWidth * 0.5, y: kScreenHeight - 160)
            introductionView?.enterButton = enterButton
            
            introductionView?.enterBlock = {
                self.introductionView?.removeFromSuperview()
                self.introductionView = nil
                
                let curVersion = kAppVersion()
                kUserDefaults.set(curVersion, forKey: kLastShowIntrolductionVersionKey)
                kUserDefaults.synchronize()
            }
        }
    }
    
    
    
    //MARK:- private funcs
    private func setDisplayVC(vc: UIViewController?, animated: Bool = false) {
        if let _vc = vc {
            rootVC.addChild(_vc)
            rootVC.view.addSubview(_vc.view)
            _vc.view.frame = rootVC.view.bounds
            if animated {
                _vc.view.transform = CGAffineTransform(translationX: 0, y: kScreenHeight)
                UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
                    _vc.view.transform = CGAffineTransform(translationX: 0, y: 0)
                })
                
            }
            
        }
    }
    
    private func removeDisplayVC(vc: UIViewController?, animated: Bool = false) {
        if let _vc = vc {
            if animated {
                
                UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
                    _vc.view.transform = CGAffineTransform(translationX: 0, y: kScreenHeight)
                }) { (_) in
                    _vc.removeFromParent()
                    _vc.view.removeFromSuperview()
                }
                
            }else {
                _vc.removeFromParent()
                _vc.view.removeFromSuperview()
            }
            
        }
    }
    
    
    
    
}
