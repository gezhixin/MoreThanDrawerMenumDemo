//
//  LeftRightMenuBaseViewController.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/23.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class LeftRightMenuBaseViewController: BaseViewController {
    
    var navigationOperation: UINavigationControllerOperation = .None
    var rootViewController: LeftRightMenuRootViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        rootViewController = appDelegate.rootLRMViewController
        
        var edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: "edgePan:")
        edgePan.edges = .Left
        self.view.addGestureRecognizer(edgePan)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //设置Bar的 title 左右Btn
    override func setLefBar()
    {
        weak var weakSelf: BaseViewController? = self
        var leftBarItem: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        var menumIcon: UIImageView = UIImageView(image: UIImage(named: "icon_menu.png"))
        leftBarItem.addSubview(menumIcon)
        menumIcon.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(leftBarItem)
            make.left.equalTo(0)
        }
        self.navigationView.setLeftItem(leftBarItem, navigationTtemClicked: { (navgationView) -> () in
            weakSelf!.leftAction()
        })
    }
    
    
    override func leftAction() {
       self.menuClicked()
    }
    
    
    func edgePan(gesture:UIScreenEdgePanGestureRecognizer)
    {
        var point = gesture.translationInView(self.view)
        
        self.rootViewController.setCenterViewOffset(point.x)
        if gesture.state == .Ended
        {
            if point.x > 60
            {
                self.rootViewController.openLeftView()
            }
            else
            {
                self.rootViewController.closeLeftView()
            }
        }
    }
    
    func menuClicked()
    {
        if(rootViewController != nil)
        {
            rootViewController.menuBtnClicked()
        }
    }
}
