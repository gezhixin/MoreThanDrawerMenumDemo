//
//  WebClient.swift
//  special
//
//  Created by 葛枝鑫 on 15/6/27.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit
import Alamofire

class WebClient: NSObject {
    
    
    class func Login(name string:String, passwd:String, sucess:(user: UserModel)->Void, failue:(code: Int, msg: String?)->Void) {
        var param = ["u": string, "p": passwd]
        STNet.postWithAction(Actions.loginAction, parameters: param, sucess: { (data) -> Void in
            var user: UserModel = UserModel()
            user.name = data!["Name"].stringValue
            user.id = data!["Id"].int64Value
            user.ImgUrl = data!["ImgUrl"].string
            user.email = data!["Email"].string
            user.sex = data!["Sex"].int
            sucess(user: user)
        }) { (code, msg) -> Void in
            failue(code: code, msg: msg)
        }
    }
   
}
