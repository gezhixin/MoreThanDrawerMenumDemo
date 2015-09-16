//
//  LeftMenuOptionTableViewCell.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/26.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import UIKit

class LeftMenuOptionTableViewCell: UITableViewCell {
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var optionIcon: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected
        {
            self.optionLabel.textColor = UIColor(hex: 0x09C7C5)
        }
        else
        {
            self.optionLabel.textColor = UIColor.blackColor()
        }
    }
    
}
