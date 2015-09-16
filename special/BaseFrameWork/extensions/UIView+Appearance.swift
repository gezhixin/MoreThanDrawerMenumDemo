//
//  UIView+Appearance.swift
//  special
//
//  Created by 葛枝鑫 on 15/4/22.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//
/**
*
*/



import UIKit
import Foundation

extension UIView {
    func setBorder(hexColor: Int, width:CGFloat)
    {
        self.layer.borderColor = UIColor(hex: hexColor).CGColor
        self.layer.borderWidth = width
    }
    
    func setCornerRadius(cornerRadius:CGFloat)
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
    }
   
}
