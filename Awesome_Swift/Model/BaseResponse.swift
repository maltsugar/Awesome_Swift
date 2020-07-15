//
//  BaseResponse.swift
//  Awesome_Swift
//
//  Created by zgy on 2020/7/15.
//  Copyright © 2020 zgy. All rights reserved.
//

import Foundation


let kResponseSuccess = "SUCCESS"
let kResponseFail = "FAIL"

struct BaseResponse: Convertible {
    
    var code: String?
    var remark: String?
    var data: Any?
    
}
