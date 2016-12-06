//
//  BannerScrollView.swift
//  Banner
//
//  Created by yaosixu on 2016/12/6.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

protocol  BannerScrollerViewDelegate: class {
    func tapWitchImageView(imageIndex: Int)
    func scrollerWichImageView(imageIndex: Int)
}

extension BannerScrollerViewDelegate {
    func tapWitchImageView(imageIndex: Int) {}
    func scrollerWichImageView(imageIndex: Int){}
}

class BannerScrollView: UIScrollView {
    
    fileprivate var currentIndex = 0
    fileprivate var lastMoveX: CGFloat = 0
    fileprivate var imageNameArray: [String]
    
    private var midContainer: UIView = UIView()
    private var midImageView: UIImageView = UIImageView()
    private var leftImageView: UIImageView = UIImageView()
    private var rightImageView: UIImageView = UIImageView()
    private var autoScrollerTime: Timer = Timer()
    
    weak var bannerScorllerDelegate: BannerScrollerViewDelegate!
    
    var time: Double = 1
    ///是否间隔一定的时间自动滑动，默认为false, 设置为true时，必须先设置time属性，time属性默认值为1
    var isAutoScrollerWithTime: Bool = false {
        didSet {
            if isAutoScrollerWithTime {
                autoScrollerTime = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(autoScrollView), userInfo: nil, repeats: true)
            }
        }
    }
    
    init(frame: CGRect,startIndex: Int, imageNameArray: [String]) {
        self.imageNameArray = imageNameArray
        self.currentIndex = startIndex
        
        super.init(frame: frame)
        
        initSetting()
        initMidContainer()
        initScrollView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func initSetting() {
        self.contentSize = CGSize(width: self.bounds.size.width * 3, height: 0)
        self.contentOffset = CGPoint(x: self.bounds.size.width, y: 0)
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bounces = false
        self.layer.masksToBounds = true
        self.delegate = self;
    }
    
    fileprivate func initMidContainer () {
        midContainer.frame = CGRect(x: self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        midContainer.clipsToBounds = true
        self.addSubview(midContainer)
        
        midImageView.frame = midContainer.bounds
        midImageView.clipsToBounds = true
        midContainer.addSubview(midImageView)
        midImageView.isUserInteractionEnabled = true
        let tapAction = UITapGestureRecognizer(target: self, action: #selector(tapMidImageView))
        midImageView.addGestureRecognizer(tapAction)
        
        leftImageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        self.addSubview(leftImageView)
        
        rightImageView.frame = CGRect(x: self.bounds.size.width * 2, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        self.addSubview(rightImageView)
    }
 
    fileprivate func initScrollView() {
        midImageView.image = UIImage(named: imageNameArray[currentIndex])
        midImageView.tag =  currentIndex
        
        var leftIndex = currentIndex - 1
        if leftIndex < 0 {
            leftIndex = imageNameArray.count - 1
        }
        leftImageView.tag = leftIndex
        leftImageView.image = UIImage(named: imageNameArray[leftIndex])
        
        var rightIndex = currentIndex + 1
        if rightIndex >= imageNameArray.count {
            rightIndex = 0
        }
        rightImageView.tag = rightIndex
        rightImageView.image = UIImage(named: imageNameArray[rightIndex])
        
        self.setContentOffset(CGPoint(x: self.bounds.size.width, y: 0), animated: false)
    }
    
    @objc private func tapMidImageView(tapView: UITapGestureRecognizer) {
        guard let targetView = tapView.view as? UIImageView else {
            return
        }
        print("\(targetView.tag)")
        bannerScorllerDelegate.tapWitchImageView(imageIndex: targetView.tag)
    }
    
    @objc private func autoScrollView() {
        print("\(#function)")
        self.setContentOffset(CGPoint(x: self.bounds.size.width * 2, y: 0), animated: true)
    }
}

extension BannerScrollView : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let moveX = scrollView.contentOffset.x - self.bounds.size.width
        if fabs(lastMoveX) >= self.bounds.size.width {
            initScrollView()
            lastMoveX = 0
            return
        }
        
        if (fabs(moveX) >= self.bounds.size.width) {
            completeScroller(moveX: moveX)
        }
        lastMoveX = moveX
    }
    
    fileprivate func completeScroller(moveX: CGFloat) {
        print("\(#function)")
        if moveX > lastMoveX {
            currentIndex += 1
            if currentIndex >= imageNameArray.count {
                currentIndex = 0
            }
        } else if moveX < lastMoveX {
            currentIndex -= 1
            if currentIndex < 0 {
                currentIndex = imageNameArray.count - 1
            }
        }
        bannerScorllerDelegate.scrollerWichImageView(imageIndex: currentIndex)
        initScrollView()
    }
    
}


