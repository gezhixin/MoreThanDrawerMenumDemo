//
//  HomePageHeaderTableViewCell.swift
//  special
//
//  Created by 葛枝鑫 on 15/5/1.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class HomePageHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var yearAndMonLabel: UILabel!
    @IBOutlet weak var weakLabel: UILabel!
    
    var delegate: HomePageHeaderViewDelegate?
    
    static func createView() -> HomePageHeaderTableViewCell
    {
       let cell = NSBundle.mainBundle().loadNibNamed("HomePageHeaderTableViewCell", owner: nil, options: nil).first as! HomePageHeaderTableViewCell
        return cell
    }

    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.setDate()
        self.layoutIfNeeded()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //日前格式
    func setDate()
    {
        var arrWeak = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
        let date = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        let timeZone = NSTimeZone(name: "Asia/Shanghai")
        let unitFlags: NSCalendarUnit = [NSCalendarUnit.Year, NSCalendarUnit.Month, NSCalendarUnit.Day, NSCalendarUnit.Weekday]

        calendar?.timeZone = timeZone!
        
        let comps = calendar?.components(unitFlags, fromDate: date)
        let week = comps?.weekday
        let year = comps?.year
        let mon = comps?.month
        let day = comps?.day
        
        let strWeak = arrWeak[week! - 1]
        let strDay = day < 10 ? "0\(day!)" : "\(day!)"
        let strYearAndMon = "\(year!)年\(mon!)月"
        self.weakLabel.text = strWeak
        self.dayLabel.text = strDay
        self.yearAndMonLabel.text = strYearAndMon
    }
    
}

@objc protocol HomePageHeaderViewDelegate : NSObjectProtocol
{
   optional func HomePageHeaderView(headerView:HomePageHeaderTableViewCell, menuBtnClicked: UIButton)
}


