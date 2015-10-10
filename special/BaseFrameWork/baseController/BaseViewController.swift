//
//  BaseViewController.swift
//  everyBook
//
//  Created by 葛枝鑫 on 15/4/10.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController{

    var navigationView: STNavigationView! = STNavigationView()
    
    //重写Init方法，加载xib文件
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //将系统的navigationBar隐藏到最后面，使用自定义的来替代
        self.navigationController!.view .sendSubviewToBack(self.navigationController!.navigationBar)
        self.setNavBar()
        self.setLefBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.view.bringSubviewToFront(self.navigationView)
    }
    
    func setNavBar()
    {
        self.view.addSubview(self.navigationView)
        self.navigationView.backgroundColor = UIColor(hex: 0x009999, alpha: 1)
        self.navigationView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(STNvaHeight)
        }
    }
    
//设置Bar的 title 左右Btn
    func setLefBar()
    {
        let leftBarItem: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        let menumIcon: UIImageView = UIImageView(image: UIImage(named: "arrow_white_01.png"))
        leftBarItem.addSubview(menumIcon)
        menumIcon.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(leftBarItem)
            make.left.equalTo(0)
        }
        self.navigationView.setLeftItem(leftBarItem, navigationTtemClicked: { (navgationView) -> () in
            self.leftAction()
        })
    }
    
    func setLeftBar(coustomView: UIView)
    {
    }
    
    func leftAction()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //right
    func setRightBar(title: String?, img: UIImage?)
    {
    }
    
    func setRightBar(coustomView: UIView)
    {
    }
    
    func rightAction()
    {
    }
    
    //tilte
    func navTitle(title: String) {
        self.navigationView!.title = title
    }
    
}
