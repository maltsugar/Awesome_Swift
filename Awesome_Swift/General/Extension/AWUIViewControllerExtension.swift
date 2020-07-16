//
//  AWUIViewControllerExtension.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/16.
//  Copyright © 2020 zgy. All rights reserved.
//

import Foundation


extension UIViewController {
    func addViewController(vc: UIViewController?) {
        if let _vc = vc {
            self.addChild(_vc);
            self.view.addSubview(_vc.view)
            _vc.view.snp.makeConstraints { (make) in
                make.edges.equalTo(0)
            }
        }
    }
}
