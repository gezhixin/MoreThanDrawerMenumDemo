//
//  LeftMenuViewController.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/16.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class LeftMenuViewController: LeftRightMenuBaseViewController, UITableViewDataSource, UITableViewDelegate, LeftMenuHeaderDelegate {
    
    var homePageViewContoller : UINavigationController!
    var favouriteViewController : UINavigationController!
    var importentDayViewController : UINavigationController!
    
    @IBOutlet weak var tableView: UITableView!
    weak var headerView: LeftMenuHeaderTableViewCell?
    
    let options = ["特别的今天", "重要的时刻", "我已收藏的", "关于", "设置"];
    let optionsIcon = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationView.hidden = true
        self.navigationController!.navigationBar.hidden = true
        var headerView = LeftMenuHeaderTableViewCell.createView()
        headerView.delegate = self
        self.headerView = headerView
        self.tableView.tableHeaderView = headerView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    override func viewWillAppear(animated: Bool) {
        
        self.tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.Top)
    }
    
    //MARK:-
    //MARK:leftMenuHeaderViewDelegate
    func leftMenuHeaderView(view: LeftMenuHeaderTableViewCell, loginBtnCliked: UIButton) {
        var vc = LoginViewController(nibName: "LoginViewController", bundle: nil) { (user) -> Void in
            
            view.updateViewWithUser(user)
            println("login success")
        }
        self.presentViewController(vc, animated: true) { () -> Void in }
    }
    
    
    //MARK: - UITableDataSource
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.options.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier("LeftMenuOptionTableViewCell") as? LeftMenuOptionTableViewCell
        if (cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("LeftMenuOptionTableViewCell", owner: nil, options: nil).first as? LeftMenuOptionTableViewCell
            cell?.optionLabel.text = options[indexPath.row]
            
        }
        return cell!
    }
    
    //MARK:- UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        switch indexPath.row
        {
            case 0:
                self.homePageClicked()
                break
            case 1:
                self.importentTimeClicked()
                break
            case 2:
                self.myFavoriteClicked()
                break
            case 3:
                self.aboutClicked()
                break
            case 4:
                self.settingClicked()
                break
            default:
                break
        }
        self.menuClicked()
    }
    
    
    //MARK: - 菜单各个选项的响应
    func homePageClicked()
    {
        self.rootViewController.centerNavigationController = self.homePageViewContoller
    }
    
    func importentTimeClicked()
    {
       self.rootViewController.centerNavigationController = self.importentDayViewController
    }
    
    func myFavoriteClicked()
    {
        self.rootViewController.centerNavigationController = self.favouriteViewController
    }
    
    func aboutClicked()
    {
    
    }
    
    func settingClicked()
    {
    
    }
    
}
