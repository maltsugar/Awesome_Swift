//
//  AWUserManager.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/15.
//  Copyright © 2020 zgy. All rights reserved.
//

import Foundation


class AWUserManager {
    static let shared = AWUserManager()
    private init() {}
    // =================
    
    //MARK:- properties
    var userID: String?
    var token: String?
    //    var loginData: LoginData?
    
    
    
    
    //MARK:- functions
    // 用户是否已登录
    func isUserLogined() -> Bool {
        // 获取用户token等
        return false
    }
    
    func saveUserInfo() {
        // 保存用户信息
    }
    
    func clearUserInfo() {
        self.token = nil;
        // self.loginData = nil;
    }
    
    
}
