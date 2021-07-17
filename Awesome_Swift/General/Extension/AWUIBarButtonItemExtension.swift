//
//  AWUIBarButtonItemExtension.swift
//  Awesome_Swift
//
//  Created by zgy on 2021/7/17.
//  Copyright © 2021 zgy. All rights reserved.
//

import Foundation

extension UIBarButtonItem
{
    public convenience init(target: Any?, action: Selector, image: String, highImage: String, imageEdgeInsets: UIEdgeInsets) {
        let btn = setupBtn(target: target, action: action, image: image, highImage: highImage, btnSize: CGSize(width: 40, height: 40), imageEdgeInsets: imageEdgeInsets)
        self.init(customView: btn)
    }
}

func setupBtn(target: Any?, action: Selector, image: String, highImage: String, btnSize: CGSize, imageEdgeInsets: UIEdgeInsets) -> UIButton {
    let btn = UIButton(type: .custom)
    btn.addTarget(target, action: action, for: .touchUpInside)
    // 设置图片
    btn.setImage(UIImage(named: image), for: .normal)
    btn.setImage(UIImage(named: highImage), for: .highlighted)
    // 设置尺寸
    btn.size = btnSize
    btn.imageEdgeInsets = imageEdgeInsets
    return btn
}


