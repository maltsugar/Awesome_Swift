//
//  AWEmptyView.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/16.
//  Copyright © 2020 zgy. All rights reserved.
//

import UIKit

class AWEmptyView: UIView {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var imgViewCenterY: NSLayoutConstraint! // -20
    
    
    @IBOutlet weak var tipLab: UILabel!
    @IBOutlet weak var tipLabTop: NSLayoutConstraint! // 15
    
    
    class func emptyView() -> Self {
        let arr = Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)
        let view = arr?.last as! AWEmptyView
        return view as! Self
    }

   
}
