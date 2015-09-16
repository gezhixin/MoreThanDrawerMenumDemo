//
//  HomePageTableViewCell.swift
//  special
//
//  Created by 葛枝鑫 on 15/5/1.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {
    
    var delegate: HomePageTableViewDelegate?
    var cardInfos: Array<NewsModel>?
    
    @IBOutlet var cards: [UIView]!
    static func createView() -> HomePageTableViewCell
    {
        var cell = NSBundle.mainBundle().loadNibNamed("HomePageTableViewCell", owner: nil, options: nil).first as! HomePageTableViewCell
        return cell
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func updateView(cards array: Array<NewsModel>)
    {
        self.cardInfos = array
        
        for (var i = 0; i < 3; i++)
        {
            if (array.count > i) {
                var model = array[i]
                
            }
            else {
               self.cards[i].hidden = true
            }
        }
    }
    
    //MARK:-IBActions
    @IBAction func card1Clicked(sender: UIButton) {
        if (self.cardInfos != nil && self.cardInfos?.count >= 1)
        {
            var model = self.cardInfos![0]
            if ((self.delegate != nil && delegate?.respondsToSelector("cardClicked:") != nil))
            {
                self.delegate!.cardClicked!(model)
            }
        }
    }
    
    @IBAction func card2Clicked(sender: UIButton) {
        if (self.cardInfos != nil && self.cardInfos?.count >= 2)
        {
            var model = self.cardInfos![0]
            if ((self.delegate != nil && delegate?.respondsToSelector("cardClicked:") != nil))
            {
                self.delegate!.cardClicked!(model)
            }
        }
    }
    
    @IBAction func card3Clicked(sender: UIButton) {
        if (self.cardInfos != nil && self.cardInfos?.count >= 3)
        {
            var model = self.cardInfos![0]
            if ((self.delegate != nil && delegate?.respondsToSelector("cardClicked:") != nil))
            {
                self.delegate!.cardClicked!(model)
            }
        }
    }
}

@objc protocol HomePageTableViewDelegate: NSObjectProtocol
{
    optional func cardClicked(news:NewsModel)
}
