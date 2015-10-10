//
//  STNavigationView.swift
//  special
//
//  Created by 葛枝鑫 on 15/6/27.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit
import SnapKit

let STNvaHeight: CGFloat = 64.0

typealias STNavigationItemClicked=(navgationView: STNavigationView?)-> ()

class STNavigationView: UIView {
    
    //MARK:-变量定义
    var title: String?  {
        didSet {
            if self.titleLabel == nil {
                self.titleLabel = UILabel()
                self.titleLabel!.font = UIFont.systemFontOfSize(16)
                self.addSubview(self.titleLabel!)
                self.titleLabel!.snp_makeConstraints(closure: { (make) -> Void in
                    make.centerY.equalTo(self.leftBarItem)
                    make.centerX.equalTo(self)
                })
            }
            self.titleLabel!.text = title!
        }
    }
    
    var leftBarItem: UIView! = UIView()
    var leftBarItems: [UIView]! = []
    
    var rightBarItem: UIView! = UIView()
    var rightBarItems: [UIView]! = []
    
    private var titleLabel: UILabel?
    private var navigationTtemClicked: STNavigationItemClicked?
    
    //MARK:-初始化
     convenience init() {
        let rect: CGRect = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: STNvaHeight)
        self.init(frame: rect);
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    //把事件放在此处处理的设计不是很科学，暂时先这样，先做主要功能
    func setLeftItem(leftBarItem: UIView?, navigationTtemClicked: STNavigationItemClicked?) {
        if leftBarItem != nil {
            self.leftBarItem = leftBarItem
            let btn: UIButton = UIButton()
            self.leftBarItem.addSubview(btn)
            btn.snp_makeConstraints { (make) -> Void in
                make.edges.equalTo(leftBarItem!).inset(UIEdgeInsetsMake(0, 0, 0, 0))
            }
            btn.addTarget(self, action: "onBarItemClicked", forControlEvents: UIControlEvents.TouchUpInside)
            
            self.addSubview(self.leftBarItem)
            self.leftBarItem.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(20)
                make.left.equalTo(10)
                make.bottom.equalTo(0)
                make.width.equalTo(60)
            }
        } else {
            self.leftBarItem.removeFromSuperview()
        }
        
        self.navigationTtemClicked = navigationTtemClicked
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- IBAction
    func onBarItemClicked() {
        if self.navigationTtemClicked != nil {
            self.navigationTtemClicked!(navgationView: self)
        }
    }
}
