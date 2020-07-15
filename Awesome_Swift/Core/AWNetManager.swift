//
//  AWNetManager.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/15.
//  Copyright © 2020 zgy. All rights reserved.
//

import Foundation


// 配置文件， 请求预处理闭包可以根据需求改变这些值
class AWNetWorkConfig {
    let sessionConfiguration = URLSessionConfiguration.default
    var requestHeaders = SessionManager.defaultHTTPHeaders
    var encoding: ParameterEncoding = URLEncoding.default
    var param: Parameters?
}

class AWNetManager {
    static let shared = AWNetManager()
    private init() {}
    // =================
    
    var baseURL: String? = ""
    var requestProcess: ((_ config: inout AWNetWorkConfig) -> Void)?
    var responseProcess: (() -> Void)?
    private var config =  AWNetWorkConfig()
    
    private lazy var sessionMgr: SessionManager = {
        config.sessionConfiguration.timeoutIntervalForRequest = 20 // 超时时间
        let manager = SessionManager(configuration: config.sessionConfiguration)
        return manager
    }()
    
    
    static func get(path: String? = nil, param: Parameters?) {
        let mgr = AWNetManager.shared
        let url = mgr.getFullURL(urlString: path)
        
        mgr.config.param = param
        mgr.requestProcess?(&mgr.config)
        
        mgr.sessionMgr.request(url, method: .get, parameters: mgr.config.param, encoding: mgr.config.encoding, headers: mgr.config.requestHeaders).responseJSON(queue: .main, options: .fragmentsAllowed) { (res) in
            printLog(res)
        }
    }
    
    static func post(path: String? = nil, param: Parameters?) {
        let mgr = AWNetManager.shared
        let url = mgr.getFullURL(urlString: path)
        mgr.config.param = param
        
        mgr.requestProcess?(&mgr.config)
        
        mgr.sessionMgr.request(url, method: .post, parameters: mgr.config.param, encoding: mgr.config.encoding, headers: mgr.config.requestHeaders).responseJSON(queue: .main, options: .fragmentsAllowed) { (res) in
            printLog(res)
        }
        
    }
    
    
    
    
    
    
    private func getFullURL(urlString: String?) -> String {
        var url = ""
        if let _base = baseURL {
            url += _base
        }
        
        if let _urlString = urlString {
            url += _urlString
        }
        return url
    }
    
    
}


