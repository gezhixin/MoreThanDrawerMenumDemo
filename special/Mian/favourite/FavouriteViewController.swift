//
//  FavouriteViewController.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/17.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class FavouriteViewController: LeftRightMenuBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle("我已收藏的")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func leftAction() {
        self.rootViewController.menuBtnClicked()
    }
}
