//
//  STUserManager.swift
//  special
//
//  Created by 葛枝鑫 on 15/7/5.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import Foundation

class STUserManager: NSObject {
    
    let currentUser: UserModel!
    override init() {
        self.currentUser = nil
    }
    
    init(user: UserModel) {
        self.currentUser = user
    }
    
    class func shareInstance()->STUserManager{
            struct Static {
                static var onceToken : dispatch_once_t = 0
                static var instance : STUserManager? = nil
            }
            dispatch_once(&Static.onceToken) {
                let user: UserModel = NSUserDefaults.standardUserDefaults().objectForKey("CURRENT_USER") as! UserModel
                Static.instance = STUserManager(user: user)
            }
            return Static.instance!
    }
}
