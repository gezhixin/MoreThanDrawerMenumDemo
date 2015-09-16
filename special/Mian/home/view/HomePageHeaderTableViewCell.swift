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
       var cell = NSBundle.mainBundle().loadNibNamed("HomePageHeaderTableViewCell", owner: nil, options: nil).first as! HomePageHeaderTableViewCell
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
        var date = NSDate()
        var calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var timeZone = NSTimeZone(name: "Asia/Shanghai")
        var unitFlags = NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekday

        calendar?.timeZone = timeZone!
        
        var comps = calendar?.components(unitFlags, fromDate: date)
        var week = comps?.weekday
        var year = comps?.year
        var mon = comps?.month
        var day = comps?.day
        
        var strWeak = arrWeak[week! - 1]
        var strDay = day < 10 ? "0\(day!)" : "\(day!)"
        var strYearAndMon = "\(year!)年\(mon!)月"
        self.weakLabel.text = strWeak
        self.dayLabel.text = strDay
        self.yearAndMonLabel.text = strYearAndMon
    }
    
}

@objc protocol HomePageHeaderViewDelegate : NSObjectProtocol
{
   optional func HomePageHeaderView(headerView:HomePageHeaderTableViewCell, menuBtnClicked: UIButton)
}


