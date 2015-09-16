//
//  HomePageViewController.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/16.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import Foundation
import UIKit

class HomePageViewController: LeftRightMenuBaseViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate, HomePageTableViewDelegate {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var news: Array<NewsModel>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationView.backgroundColor = UIColor.clearColor()
        self.setSlarView()
        self.tableView.tableHeaderView = HomePageHeaderTableViewCell.createView()
        self.view.bringSubviewToFront(self.tableView)
        
        ArticleWebClient.index()
        self.news = [self.createModel(),self.createModel(),self.createModel(),self.createModel(),self.createModel(),self.createModel(),self.createModel(),self.createModel(),self.createModel(),self.createModel()]
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated:false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //test codes
    func createModel() -> NewsModel
    {
        var model = NewsModel()
        model.title = "人类第一次登月"
        model.content = "发生解决发生就放假啊斯洛伐克将离开房间的发空间 撒打发时间了打法就离开是对法律卡积分的发掘经济困境就看见阿斯科利发动机快乐阿萨德发"
        return model
    }
    
   
    func setSlarView()
    {
        var solar = SolarViewController(nibName:"SolarViewController", bundle:nil)
        solar.view.frame = CGRect(x: 0, y: 10, width: self.view.bounds.width, height: 300)
        self.view.addSubview(solar.view)
        self.addChildViewController(solar)
    }
    
    //MARK: - UITableDataSource
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 104
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if self.news != nil {
            return self.news!.count / 3 + 1
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let identifier = "HomePageTableViewCell"
        var cell  = tableView.dequeueReusableCellWithIdentifier(identifier) as? HomePageTableViewCell
        if  cell == nil
        {
            cell = HomePageTableViewCell.createView()
        }
        cell!.delegate = self
        cell?.updateView(cards: self.getNews(indexPath.row))
        return cell!
    }
    
    func getNews(index: Int) -> Array<NewsModel>
    {
        var newsArr = Array<NewsModel>()
        var end = index * 3 + 3;
        for ( var i = index * 3; i < end; i++)
        {
            if (self.news?.count > i)
            {
                var model = self.news![i]
                newsArr.append(model)
            }
        }
        return newsArr
    }
    
    //MARK: - HomePageCardViewDelegate
    func cardClicked(news: NewsModel) {
        var vc = DetailViewController(nibName:"DetailViewController", bundle:nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
