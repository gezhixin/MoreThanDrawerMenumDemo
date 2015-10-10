//
//  DetailViewController.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/26.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit
import SwiftyJSON

class DetailViewController: BaseViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle("文章详情")
        self.getArticle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    func getArticle() {
        STNet.postWithAction(Actions.articleIndex, parameters: nil, sucess: { (data) -> Void in
            let html: String = data!["articleList"][2]["Content"].string!
            self.webView?.loadHTMLString(html, baseURL: nil)
        }) { (code, msg) -> Void in
            print(msg!)
        }
    }
}
