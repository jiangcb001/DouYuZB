//
//  PageTitlesView.swift
//  DYZB
//
//  Created by easy on 2019/6/10.
//  Copyright © 2019 easy. All rights reserved.
//

import UIKit

//MARK:   定义颜色常量
private let kNorColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kSeleColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

protocol PageTitlesViewDelegate : class {
    func selecteTitleToContent(titleView : PageTitlesView, selectedIndex index : Int)
}

class PageTitlesView: UIView {
    
    private let kscrollLineH : CGFloat = 2
    
    //MARK:-属性
    //MARK:-标题数组
    private var titles : [String]
    //MARK:-选中的title
    private var oldLabelIndex : Int = 0
    //label数组
    private lazy var labels : [UILabel] = [UILabel]()
    //title下面的黄色线
    private lazy var scrollLine : UIView = UIView()
    //代理
    weak var delegate : PageTitlesViewDelegate?
    
    //MARK:-懒加载scrollView
    private lazy var scrollView : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    //MARK:-设置初始化
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitlesView{
    private func setUpUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        setTitleLabels()
        setupBottomLineAndScrollLine()
        //设置默认第一个title橙色
        guard let firstLabel = labels.first else { return }
        firstLabel.textColor = UIColor.orange
    }
    
    private func setTitleLabels() {
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kscrollLineH
        let labelY : CGFloat = 0
        
        for(index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = NSTextAlignment.center
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            scrollView.addSubview(label)
            labels.append(label)
            //添加点击事件
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.labelTapGes(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    private func setupBottomLineAndScrollLine() {
        let bottomLine = UIView()
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: frame.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        
        guard let firstlabel = labels.first else { return }
        scrollLine.backgroundColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstlabel.frame.origin.x, y:frame.height - kscrollLineH  , width: firstlabel.frame.width, height: kscrollLineH)
        scrollView.addSubview(scrollLine)
        
    }
    
}

extension PageTitlesView {
    @objc private func labelTapGes(tapGes : UITapGestureRecognizer) {
        //颜色切换
        guard let selectLabel = tapGes.view as? UILabel else { return }
        let oldLabel : UILabel = labels[oldLabelIndex]
        selectLabel.textColor = UIColor.orange
        oldLabel.textColor = UIColor.darkGray
        oldLabelIndex = selectLabel.tag
        
        let scrollLineX = CGFloat(selectLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //通知代理
        delegate?.selecteTitleToContent(titleView: self, selectedIndex: selectLabel.tag)
        
    }
}

//MARK:-接口方法
extension PageTitlesView {
    func setTitleWithProgress(progress : CGFloat, sourceIndex: Int, targetIndex: Int) {
        let sourceLabel = labels[sourceIndex]
        let targetLabel = labels[targetIndex]
        
        let moveTotal = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotal * progress
        print(moveX)
        scrollLine.frame.origin.x = moveX + sourceLabel.frame.origin.x
        
        //title 颜色变化
        //获取变化范围
        let colorDelta = (kSeleColor.0 - kNorColor.0, kSeleColor.1 -  kNorColor.1, kSeleColor.2 - kNorColor.2)
        
        //变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSeleColor.0 - colorDelta.0 * progress, g: kSeleColor.1 - colorDelta.1 * progress, b: kSeleColor.2 - colorDelta.2 * progress)
        
        //变化targertLabel
        targetLabel.textColor =  UIColor(r: kNorColor.0 + colorDelta.0 * progress, g: kNorColor.1 + colorDelta.1 * progress, b: kNorColor.2 + colorDelta.2 * progress)
        
        oldLabelIndex = targetIndex
        
    }
}

