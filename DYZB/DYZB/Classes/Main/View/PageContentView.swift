//
//  PageContentView.swift
//  DYZB
//
//  Created by easy on 2019/6/11.
//  Copyright © 2019 easy. All rights reserved.
//

import UIKit

private let contentCellID = "ContentCellID"
class PageContentView: UIView {
    
    private var childVcs : [UIViewController]
    private weak var parentViewController : UIViewController?
    private var scrollBegainOffsetX : CGFloat = 0
    
    private lazy var collectionView : UICollectionView = {[weak self] in
     
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect.zero , collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    init(frame : CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:-设置UI
extension PageContentView {
    private func setUpUI() {
        //1.将所有子控制器添加到父控制器中
        for childVC in childVcs {
            parentViewController?.addChild(childVC)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        //先移除view
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        //再添加view
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//接口方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        let contentOffsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: contentOffsetX, y: 0), animated: false)
    }
}

extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollBegainOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var proress : CGFloat = 0 //滑动比例
        var scrollViewW = scrollView.bounds.width

        proress = scrollBegainOffsetX / scrollViewW - floor(scrollBegainOffsetX / scrollViewW)
        
        if scrollView.contentOffset.x > scrollBegainOffsetX {//左滑
            print("------------")
        }else{//右滑
            print("+++++++++++++")
        }
        
        
        
    }
}
