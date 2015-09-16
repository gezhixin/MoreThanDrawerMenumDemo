//
//  LeftMenuHeaderTableViewCell.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/30.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class LeftMenuHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var loginBtn: UIButton!
    var delegate: LeftMenuHeaderDelegate?
    
    @IBOutlet weak var headView: UIImageView!
    static func createView() -> LeftMenuHeaderTableViewCell
    {
        var view = NSBundle.mainBundle().loadNibNamed("LeftMenuHeaderTableViewCell", owner: nil, options: nil).first as! LeftMenuHeaderTableViewCell
        return view
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.headView.setCornerRadius(20)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateViewWithUser(user: UserModel) {
        self.loginBtn.setTitle(user.name, forState: UIControlState.Normal)
    }
    
    //MARK:- Actions
    
    @IBAction func loginBtnClicked(sender: UIButton) {
        if(delegate != nil && delegate?.respondsToSelector("leftMenuHeaderView:loginBtnCliked:") != nil){
            delegate!.leftMenuHeaderView!(self, loginBtnCliked: sender)
        }
    }
}

@objc protocol LeftMenuHeaderDelegate: NSObjectProtocol {
    optional func leftMenuHeaderView(view: LeftMenuHeaderTableViewCell, loginBtnCliked:UIButton)
}
