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
    
    /// 请求预处理，可以添加通用的参数
    var param: Parameters?
    
    /// DEBUG模式是否Log请求信息
    var debugPrintLog = false
}

class AWNetManager {
    static let shared = AWNetManager()
    private init() {}
    // =================
    
    var baseURL: String? = ""
    var config =  AWNetWorkConfig()
    var requestProcess: ((_ config: inout AWNetWorkConfig) -> Void)?
    var responseProcess: ((DataResponse<Any>) -> DataResponse<Any>)?
    
    
    private lazy var sessionMgr: SessionManager = {
        config.sessionConfiguration.timeoutIntervalForRequest = 20 // 超时时间
        let manager = SessionManager(configuration: config.sessionConfiguration)
        return manager
    }()
    
    @discardableResult
    static func get(path: String?, param: Parameters?, response: ((DataResponse<Any>) -> Void)? = nil) -> DataRequest {
        let mgr = AWNetManager.shared
        let url = mgr.getFullURL(urlString: path)
        
        mgr.config.param = param
        mgr.requestProcess?(&mgr.config)
        
        let dataReq = mgr.sessionMgr.request(url, method: .get, parameters: mgr.config.param, encoding: mgr.config.encoding, headers: mgr.config.requestHeaders)
        dataReq.responseJSON(queue: .main, options: .fragmentsAllowed) { (res) in
            #if DEBUG
            if (mgr.config.debugPrintLog) {
                debugPrint(res)
            }
            #endif
            let processedRes = mgr.responseProcess?(res)
            response?(processedRes ?? res)
        }
        return dataReq
        
    }
    
    @discardableResult
    static func post(path: String?, param: Parameters?, response: ((DataResponse<Any>) -> Void)? = nil) -> DataRequest {
        let mgr = AWNetManager.shared
        let url = mgr.getFullURL(urlString: path)
        mgr.config.param = param
        
        mgr.requestProcess?(&mgr.config)
        
        let dataReq = mgr.sessionMgr.request(url, method: .post, parameters: mgr.config.param, encoding: mgr.config.encoding, headers: mgr.config.requestHeaders)
        dataReq.responseJSON(queue: .main, options: .fragmentsAllowed) { (res) in
            #if DEBUG
            if (mgr.config.debugPrintLog) {
                debugPrint(res)
            }
            #endif
            let processedRes = mgr.responseProcess?(res)
            response?(processedRes ?? res)
        }
        return dataReq
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


