//
//  ArticleWebClient.swift
//  special
//
//  Created by 葛枝鑫 on 15/7/11.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class ArticleWebClient: NSObject {
   
    class func index() {
        STNet.postWithAction(Actions.articleIndex, parameters: nil, sucess: { (data) -> Void in
           print(data!)
        }) { (code, msg) -> Void in
            print(msg!)
        }
    }
}
