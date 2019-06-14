//
//  RecommendViewController.swift
//  DYZB
//
//  Created by easy on 2019/6/14.
//  Copyright © 2019 easy. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItem_W = (kScreenW - 3 * kItemMargin) / 2
private let kItem_H = kItem_W * 3/4

class RecommendViewController: UIViewController {

    
    private lazy var collectionView : UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItem_W, height: kItem_H)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        let colleView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        colleView.backgroundColor = UIColor.red
        return colleView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
