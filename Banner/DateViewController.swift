//
//  DateViewController.swift
//  Banner
//
//  Created by yaosixu on 2017/1/16.
//  Copyright © 2017年 Jason_Yao. All rights reserved.
//

import UIKit
class DateViewController: UIViewController {

    fileprivate lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint(x: 0, y: 300), size: CGSize.zero)
        label.sizeToFit()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        self.view.addSubview(label)
        return label
    }()
    
    fileprivate lazy var monthLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint(x: 0, y: 350), size: CGSize.zero)
        label.sizeToFit()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        self.view.addSubview(label)
        return label
    }()
    
    fileprivate lazy var weekdayLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint(x: 0, y: 400), size: CGSize.zero)
        label.sizeToFit()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        self.view.addSubview(label)
        return label
    }()
    
    fileprivate lazy var dayLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint(x: 0, y: 450), size: CGSize.zero)
        label.sizeToFit()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        self.view.addSubview(label)
        return label
    }()
    
    fileprivate lazy var normalDateLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint(x: 0, y: 500), size: CGSize.zero)
        label.sizeToFit()
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        self.view.addSubview(label)
        return label
    }()
    
    fileprivate lazy var locationGMTDateLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(origin: CGPoint(x: 0, y: 550), size: CGSize.zero)
        label.backgroundColor = UIColor.black
        label.textColor = UIColor.white
        self.view.addSubview(label)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
        addDateView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addDateView() {
        let dateScrollView = DateScrollView(frame: CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 60),
                                            weekLabelColor: UIColor.white, dayLabelColor: UIColor.red,
                                            maskViewColor: UIColor.black, maskViewAlpha: 0.6)
        dateScrollView.chooseDelegate = self
        dateScrollView.backgroundColor = UIColor.cyan
        view.addSubview(dateScrollView)
    }
    
}

extension DateViewController : DateScrollViewChooseDateItemDalegate {
    
    func getNormlDate(date: Date) {
        normalDateLabel.text = "有时差:\(date)"
        normalDateLabel.sizeToFit()
    }
    
    func getLocationGMTDate(date: Date) {
        locationGMTDateLabel.text = "无时差: \(date)"
        locationGMTDateLabel.sizeToFit()
    }
    
    func getDateInto(dateInfo: (Int, Int, Int, Int)) {
        yearLabel.text = "\(dateInfo.0)年"
        yearLabel.sizeToFit()
        monthLabel.text = "\(dateInfo.1)月"
        monthLabel.sizeToFit()
        weekdayLabel.text = "周\(dateInfo.2)"
        weekdayLabel.sizeToFit()
        dayLabel.text = "\(dateInfo.1)月\(dateInfo.3)日"
        dayLabel.sizeToFit()
    }
    
}
