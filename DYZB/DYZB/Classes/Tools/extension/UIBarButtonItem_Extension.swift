//
//  UIBarButtonItem_Extension.swift
//  DYZB
//
//  Created by easy on 2019/6/10.
//  Copyright © 2019 easy. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
//    class func createItem(imgName: String, highImgName: String, size: CGSize) -> UIBarButtonItem {
//        let btn = UIButton()
//        btn.setImage(UIImage(named: imgName), for: .normal)
//        btn.setImage(UIImage(named: highImgName), for: .highlighted)
//        btn.frame = CGRect(origin: CGPoint.zero, size: size)
//        return UIBarButtonItem(customView: btn)
//    }
    convenience init(imgName: String, highImgName: String = "", size: CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imgName), for: .normal)
        if highImgName != "" {
           btn.setImage(UIImage(named: highImgName), for: .highlighted)
        }
        
        if size == CGSize.zero {
           btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: btn)
    }
    
}


