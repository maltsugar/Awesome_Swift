//
//  AWConfigManager.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/15.
//  Copyright © 2020 zgy. All rights reserved.
//

import Foundation

enum AWConfigEnv {
    case dev
    case uat
    case prod
}
// 环境切换
fileprivate let kConfigEnv: AWConfigEnv = .uat





/// 是否允许修改后存本地，默认true
fileprivate var _allowPersistent = true

fileprivate let _kAWConfigManagerBaseURLKey = "kAWConfigManagerBaseURLKey"
fileprivate let _kAWConfigManagerPathKey = "kAWConfigManagerPathKey"


// 请求的特殊参数名称
let kInterfaceActionKey = "action"
let kInterfaceLoginOptionKey = "option"
let kGatewayTokenKey = "gatewayToken";


class AWConfigManager {
    static let shared = AWConfigManager()
    private init() {
        setup()
    }
    // =================
    
    
    
    
    
    
    //MARK:- properties
    var baseURL: String?
    var path: String?
    var appID: String?
    
    var OSSPolicyBaseURL: String?
    var OSSPolicyPath: String?
    
    let apiVersion = "V1.0" // 接口版本
    
    
    
    
    
    //MARK:- functions
    
    private func setup() {
        
        // 开发环境
        if kConfigEnv == .dev {
            baseURL = "http://192.168.1.48"
            path = "/api/service"
            appID = "br5hdo7evlvqvltd"  // dev
            
            
            OSSPolicyBaseURL = baseURL
            OSSPolicyPath = "op/oss/ossapptoken"
            
            if _allowPersistent {
                if let info0 = kUserDefaults.string(forKey: _kAWConfigManagerBaseURLKey), info0.count > 0 {
                    baseURL = info0
                }
                
                if let info1 = kUserDefaults.string(forKey: _kAWConfigManagerPathKey), info1.count > 0 {
                    path = info1
                }
                
            }
        }
        
        
        
        // ============================================================================================================
        // =========================================  UAT 和 生产环境 ===================================================
        
        if kConfigEnv == .uat {
            // UAT环境
            baseURL = "https://uatpxapi.yundasys.com:443"
            path = "/gateway/interface"
            appID = "vyhzro6s23ljdwhb"
            
            OSSPolicyBaseURL = baseURL
            OSSPolicyPath = "op/oss/ossapptoken"
        }
        
        if kConfigEnv == .prod {
            // 生产环境
            baseURL = "https://op.51huochedai.com"
            path = "/api/service"
            appID = "7n2acoc95yy73rs9"
            
            OSSPolicyBaseURL = baseURL
            OSSPolicyPath = "op/oss/ossapptoken"
        }
        
        // 配置请求库的baseURL、超时、证书、错误处理等
        let netMgr = AWNetManager.shared
        if let _base = baseURL, let _path = path {
            netMgr.baseURL = _base + _path
        }
        
        netMgr.requestProcess = { (config) in
            config.sessionConfiguration.timeoutIntervalForRequest = 10
            config.encoding = JSONEncoding.default
            let token = "112333"
            if token.count > 0 {
                config.requestHeaders["ydCommanderAuthToken"] = token
            }
            
            config.param = AWConfigManager.convertParam(orign: config.param)
            
            
        }
        
        
        
        
    }
}

extension AWConfigManager {
    static func convertParam(orign: [String: Any]?) -> [String: Any] {
        guard let _orign = orign else {
            return ["":""]
        }
        
        var orignCopy = _orign
        for k in orignCopy.keys {
            if k == kInterfaceActionKey || k == kInterfaceLoginOptionKey {
                orignCopy.removeValue(forKey: k)
            }
        }
        
        let configMgr = AWConfigManager.shared
        
        let version = kAppVersion()
        let timeStamp = String(Int(Date().timeIntervalSince1970))
        
        var newParam = [String: Any]()
        newParam["version"] = configMgr.apiVersion
        newParam["appid"] = configMgr.appID
        newParam["appVersion"] = "iOS\(version)"
        newParam["req_time"] = timeStamp
        newParam["data"] = orignCopy
        newParam[kInterfaceActionKey] = _orign[kInterfaceActionKey]
        if let loginOption = _orign[kInterfaceLoginOptionKey] {
            newParam[kInterfaceLoginOptionKey] = loginOption
        }
        
        //        if let gatewayToken = AWUserManager.shared.loginData.gatewayToken, gatewayToken.count > 0 {
        //            newParam["token"] = gatewayToken
        //        }
        
        
        return newParam
    }
}

