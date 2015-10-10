//
//  UIColer+GodEraAdd.swift
//  everyBook
//
//  Created by 葛枝鑫 on 15/4/11.
//  Copyright (c) 2015年 葛枝鑫. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(hex: Int) {
        self.init(hex:hex, alpha: 1)
    }
    
    convenience init(hex: Int, alpha: CGFloat) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        
        self.init(red:red, green: g, blue: b, alpha: alpha)
    }
    
}