//
//  HomeViewController.swift
//  DYZB
//
//  Created by easy on 2019/6/10.
//  Copyright © 2019 easy. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    private lazy var titlesView : PageTitlesView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kNavBarH+kStatusBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitlesView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView : PageContentView = {[weak self] in
        let contentViewH : CGFloat = kScreenH - kStatusBarH + kNavBarH + kTitleViewH
        let frame = CGRect(x: 0, y: kStatusBarH + kNavBarH+kTitleViewH, width: kScreenW, height: contentViewH)
        var childVcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: frame, childVcs: childVcs, parentViewController: self)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }

}

extension HomeViewController {
    
    
    private func setUI(){
        setupNavBar()
        automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(titlesView)
        self.view.addSubview(pageContentView)
    }
    
    private func setupNavBar() {
        //左侧btn
        navigationItem.leftBarButtonItem = UIBarButtonItem(imgName: "tab_home_click")
        
        //右侧btn
        let myItemSize = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imgName: "image_my_history", highImgName: "scanIconHL", size: myItemSize)
        let searchItem = UIBarButtonItem(imgName: "searchBtnIcon", highImgName: "searchBtnIconHL", size: myItemSize)
        let rqCodeItem = UIBarButtonItem(imgName: "scanIcon", highImgName: "scanIconHL", size: myItemSize)
        navigationItem.rightBarButtonItems = [historyItem, searchItem, rqCodeItem]
        
    }
}


extension HomeViewController : PageTitlesViewDelegate {
    func selecteTitleToContent(titleView: PageTitlesView, selectedIndex index: Int) {
       pageContentView.setCurrentIndex(currentIndex: index)
    }
    
    
}
