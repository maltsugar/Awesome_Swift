//
//  DemoViewController0.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/23.
//  Copyright © 2020 zgy. All rights reserved.
//

import UIKit
import WebKit

class DemoViewController0: AWBaseViewController {
    
    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(webView)
        webView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        if let url = URL(string: "https://www.sina.com.cn") {
            webView.load(URLRequest(url: url))
        }
        
        webView.navigationDelegate = self
       
        
        let btn = UIButton(type: .custom)
        self.view.addSubview(btn)
        btn.addTarget(self, action: #selector(handleBtnAction), for: .touchUpInside)
        btn.setTitle("刷新", for: .normal)
        btn.backgroundColor = .gray
        btn.snp.makeConstraints { (make) in
            make.width.equalTo(60)
            make.height.equalTo(40)
            make.top.equalTo(100)
            make.right.equalTo(0)
        }
    }
    
    
    @objc func handleBtnAction() {
        if let url = URL(string: "https://www.sina.com.cn") {
            webView.load(URLRequest(url: url))
        }
    }
    
     deinit {
         printLog("释放了")
     }

}

extension DemoViewController0: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        printLog("开始加载")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        printLog("1111")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        printLog("加载完成")
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        printLog("加载失败")
    }
}
