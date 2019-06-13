//
//  UIColor_Extension.swift
//  DYZB
//
//  Created by easy on 2019/6/11.
//  Copyright © 2019 easy. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r:CGFloat, g:CGFloat, b:CGFloat){
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
}
