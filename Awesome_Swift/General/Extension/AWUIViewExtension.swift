//
//  AWUIViewExtension.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/16.
//  Copyright © 2020 zgy. All rights reserved.
//

import Foundation

private var kEmptyViewKey = 100

extension UIView {
    var emptyView: UIView? {
        set {
            objc_setAssociatedObject(self, &kEmptyViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            var v = (objc_getAssociatedObject(self, &kEmptyViewKey) as? UIView)
            if nil == v {
                v = AWEmptyView.emptyView()
                self.emptyView = v
            }
            return v
        }
    }
    
    
    
    func setCorners(_ corners: UIRectCorner, radius: CGFloat) {
        
        if #available(iOS 11.0, *) {
            var _coner: CACornerMask = []
            if corners.contains(.topLeft) {
                _coner.insert(.layerMinXMinYCorner)
            }
            if corners.contains(.topRight) {
                _coner.insert(.layerMaxXMinYCorner)
            }
            if corners.contains(.bottomLeft) {
                _coner.insert(.layerMinXMaxYCorner)
            }
            if corners.contains(.bottomRight) {
                _coner.insert(.layerMaxXMaxYCorner)
            }
            layer.cornerRadius = radius
            layer.maskedCorners = _coner
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.frame = bounds
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func setShadow(color: UIColor, offset: CGSize, opacity: CGFloat, radius: CGFloat) {
        let shadowPath = UIBezierPath(rect: bounds)
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = Float(opacity)
        layer.shadowRadius = radius
        layer.shadowPath = shadowPath.cgPath
    }
}
