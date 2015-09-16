//
//  STNet.swift
//  special
//
//  Created by 葛枝鑫 on 15/6/27.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class STNet: NSObject {

    class func postWithAction(action: String, parameters: Dictionary<String, String>?, sucess:(data: JSON?)->Void, failure:(code:Int, msg: String?)->Void) -> Void {
        var url = APP_API_URL + action
        let parametersWithDefualt = self.addDefaultParameters(parameters)
        Alamofire.request(.POST, url, parameters: parametersWithDefualt, encoding: .URL).responseJSON { (request, response, json, error) in
            println("request URL : \(request.URLString)")
            
            //网络错误
            if error != nil {
                failure(code: error!.code, msg:"网络连接错误")
                return
            }
            
            var content = JSON(json!)
            var myErrorCode: Int = content["errorCode"].intValue
            
            //自定义错误
            if myErrorCode != 0 {
                var myErrorMsg: String = content["errorMsg"].stringValue
                failure(code: myErrorCode, msg: myErrorMsg)
                return
            }
            
            var data: JSON? = content["content"]
            //网络请求成功
            if data != nil {
                sucess(data: data!)
            } else {
                failure(code: -1, msg: "非标准格式数据")
            }
        }
    }

    class func addDefaultParameters(Parameters: Dictionary<String, String>?) -> Dictionary<String, String>{
        var retDictionay: Dictionary<String, String> = Parameters != nil ? Parameters! : Dictionary<String, String>();
        retDictionay["os"] = "iOS"
        retDictionay["sv"] = UIDevice.currentDevice().systemVersion
        return retDictionay
    }
}
