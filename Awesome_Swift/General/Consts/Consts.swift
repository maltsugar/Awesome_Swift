//
//  Consts.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/6/23.
//  Copyright © 2020 zgy. All rights reserved.
//

import Foundation

let kStatusBarHeight = UIApplication.shared.statusBarFrame.size.height
let kNavBarHeight = CGFloat(44)
let kTopHeight = (kStatusBarHeight + kNavBarHeight)
let kTabBarHeight = (CGFloat(49) + bottomSafeHeight())
let kBottomSafeHeight = bottomSafeHeight()
func bottomSafeHeight() -> CGFloat {
    var safe = CGFloat(0)
    if let delegate = UIApplication.shared.delegate, let mainWindow = delegate.window {
        if #available(iOS 11.0, *) {
            safe = mainWindow?.safeAreaInsets.bottom ?? CGFloat(0)
        }
    }
    return safe
}


let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kScreenSize = UIScreen.main.bounds.size

let kApplication = UIApplication.shared
let kKeyWindow = UIApplication.shared.keyWindow
let kAppDelegate = UIApplication.shared.delegate
let kUserDefaults = UserDefaults.standard
let kNotificationCenter = NotificationCenter.default

// 上次展示开屏引导页的版本号Key，不需要显示时，直接启动时同步为当前版本号即可， 需要显示时在点击确定后同步为当前版本号
let kLastShowIntrolductionVersionKey = "kLastShowIntrolductionVersionKey"


let kSystemVersion = UIDevice.current.systemVersion
let kUpdateAddress = "https://itunes.apple.com/cn/app/id1306589146?mt=8"
let kISiPhone = (UIDevice.current.userInterfaceIdiom == .phone)
let kISiPad = (UIDevice.current.userInterfaceIdiom == .pad)


// 沙盒的Document路径
let kDocumentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
// 沙盒的temp路径
let kTempPath = NSTemporaryDirectory()
// 获取沙盒的Cache路径
let kCachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first


#if TARGET_IPHONE_SIMULATOR
// 模拟器
#else
// 真机
#endif




// 计算高度
func kSTRING_HEIGHT(_ width: CGFloat, _ string: String, _ fsize: CGFloat) -> CGFloat {
    let s = NSString(string: string)
    let rect = s.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fsize)], context: nil)
    return rect.size.height
}
// 计算宽度
func kSTRING_WIDTH(_ height: CGFloat, _ string: String, _ fsize: CGFloat) -> CGFloat {
    let s = NSString(string: string)
    let rect = s.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fsize)], context: nil)
    return rect.size.width
}



public func kHexAColor(_ hexValue: Int, _ alpha: Float = 1.0) -> UIColor {
    return kRGBAColor(Float((hexValue & 0xFF0000) >> 16), Float((hexValue & 0xFF00) >> 8), Float(hexValue & 0xFF), alpha)
}

public func kRGBAColor(_ r: Float, _ g: Float, _ b: Float, _ a: Float = 1.0) -> UIColor {
    return UIColor(red: CGFloat(CGFloat(r)/255.0), green: CGFloat(CGFloat(g)/255.0), blue: CGFloat(CGFloat(b)/255.0), alpha: CGFloat(a))
}


func kImageNamed(_ name: String) -> UIImage {
    guard let _img = UIImage(named: name) else {
        return UIImage()
    }
    return _img
}

func kIMAGE(_ nameInBundle: String?) -> UIImage {
    guard let _img = UIImage(contentsOfFile: Bundle.main.path(forResource: nameInBundle, ofType: nil) ?? "") else {
        return UIImage()
    }
    return _img
}

// Version
func kAppShortVersion() -> String {
    var s = ""
    if let dict = Bundle.main.infoDictionary {
        if let v = dict["CFBundleShortVersionString"] as? String {
            s = v
        }
    }
    return s
}

// Build
func kAppVersion() -> String {
    var s = ""
    if let dict = Bundle.main.infoDictionary {
        if let v = dict["CFBundleVersion"] as? String {
            s = v
        }
    }
    return s
}


func kDegreesToRadian(x: CGFloat) -> CGFloat {
    return CGFloat(Double.pi) * x / 180.0
}

func kRadianToDegrees(radian: CGFloat) -> CGFloat {
    return (radian * 180.0) / CGFloat(Double.pi)
}


// Print
fileprivate class PrintHelper {
    static let shared = PrintHelper()
    private init(){}
    
    lazy var dateFormatter: DateFormatter = {
        let df = AppTools.shared.dateFmtter
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df
    }()
    
    var timesInfo: String {
        get {
            return dateFormatter.string(from: Date())
        }
    }
}
/// 自定义Log
func printLog<T>(_ message: T,
                 file: String = #file,
                 method: String = #function,
                 line: Int = #line)
{
    #if DEBUG
    print("\(PrintHelper.shared.timesInfo) [\((file as NSString).lastPathComponent)[\(line)], \(method)]: \(message)")
    #endif
}

// 防止多次调用
//#define kGYCancelActionInTime(_seconds_) \
//static BOOL shouldPrevent; \
//if (shouldPrevent) return; \
//shouldPrevent = YES; \
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((_seconds_) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ \
//shouldPrevent = NO; \
//}); \


@_exported import SnapKit
@_exported import KakaJSON
@_exported import Alamofire
