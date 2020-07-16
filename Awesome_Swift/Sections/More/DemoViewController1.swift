//
//  DemoViewController1.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/23.
//  Copyright © 2020 zgy. All rights reserved.
//

import UIKit

class DemoViewController1: AWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.view.emptyView!)
        self.view.emptyView?.snp.makeConstraints({ (make) in
            make.edges.equalTo(0)
        })
    }
    
    deinit {
        printLog("释放了")
    }

}
