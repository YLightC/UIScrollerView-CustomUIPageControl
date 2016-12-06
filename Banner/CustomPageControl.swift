//
//  CustomPageControl.swift
//  Banner
//
//  Created by yaosixu on 2016/12/6.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class CustomPageControl: UIView {
    ///当前页
    var currentPage: Int = 0 {
        didSet {
            changeDotsColor()
        }
    }
    
    ///总页数
    var numberOfPage: Int = 0 {
        didSet {
            addDots()
            var frame = self.frame
            frame.size.width = CGFloat(numberOfPage) * dotsSize.width + CGFloat(numberOfPage - 1) * dotsBetweenSpace
            frame.size.height = dotsSize.height
            self.frame = frame
        }
    }
    
    ///当前页颜色
    var currentPageColor: UIColor = UIColor.white {
        didSet {
            changeDotsColor()
        }
    }
    
    ///未选中页颜色
    var pageColor: UIColor = UIColor.gray {
        didSet {
            changeDotsColor()
        }
    }
    
    ///点与点之间的间隔
    private var dotsBetweenSpace: CGFloat
    ///点的大小
    private var dotsSize: CGSize
    
    init(dotsSize:CGSize = CGSize(width: 10, height: 10), dotsBetweenSpace: CGFloat = 10) {
        self.dotsBetweenSpace = dotsBetweenSpace
        self.dotsSize = dotsSize
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addDots() {
        for i  in 0..<numberOfPage {
            let view = UIView(frame: CGRect(x: caculateDotsOriginX(dotsIndex: i), y: 0, width: dotsSize.width, height: dotsSize.height))
            view.layer.cornerRadius = min(dotsSize.width / 2, dotsSize.height / 2)
            view.layer.masksToBounds = true
            self.addSubview(view)
            if currentPage == i {
                view.backgroundColor = currentPageColor
            } else {
                view.backgroundColor = pageColor
            }
        }
    }
    
    private func changeDotsColor() {
        for i in 0..<numberOfPage {
            if i == currentPage {
                self.subviews[i].backgroundColor = currentPageColor
            } else {
                self.subviews[i].backgroundColor = pageColor
            }
        }
    }
    
    private func caculateDotsOriginX(dotsIndex: Int) -> CGFloat {
        return CGFloat(dotsIndex) * (dotsBetweenSpace + dotsSize.width)
    }
    
}
