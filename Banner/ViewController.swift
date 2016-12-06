//
//  ViewController.swift
//  Banner
//
//  Created by yaosixu on 2016/12/6.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let imageNameArray: [String] = ["0","1","2"]
    var pageControl: CustomPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let bannerFrame = CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 200)
        let bannerSocrller = BannerScrollView(frame: bannerFrame, startIndex: 0, imageNameArray: imageNameArray)
        bannerSocrller.bannerScorllerDelegate = self
        bannerSocrller.time = 2.5
        bannerSocrller.isAutoScrollerWithTime = true
        view.addSubview(bannerSocrller)
        addPageControl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    fileprivate func addPageControl() {
        pageControl = CustomPageControl(dotsSize: CGSize(width: 20, height: 20), dotsBetweenSpace: 20)
        pageControl.frame.origin = CGPoint(x: 100, y: 150)
        pageControl.numberOfPage = imageNameArray.count
        view.addSubview(pageControl)
    }
}

extension ViewController : BannerScrollerViewDelegate {
    func tapWitchImageView(imageIndex: Int) {
        
    }
    
    func scrollerWichImageView(imageIndex: Int) {
        pageControl.currentPage = imageIndex
    }
}
