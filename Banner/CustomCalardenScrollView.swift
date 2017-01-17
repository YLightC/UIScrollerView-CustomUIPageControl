//
//  CustomCalardenScrollView.swift
//  Banner
//
//  Created by yaosixu on 2017/1/17.
//  Copyright © 2017年 Jason_Yao. All rights reserved.
//

import UIKit

protocol DateScrollViewChooseDateItemDalegate: class {
    /// 返回选中的时间(有时差)
    ///
    /// - Parameter date: 选中的时间
    func getNormlDate(date: Date)
    
    /// 返回选中的时间(无时差)
    ///
    /// - Parameter date: 选中的时间
    func getLocationGMTDate(date: Date)
    
    /// 返回选中时间的信息，如年、月、星期、当前月的第几天
    ///
    /// - Parameter dateInfo: 参数为元组, 0为年、1为月、2为星期、3为1中的第几天
    func getDateInto(dateInfo: (Int, Int, Int, Int))
}

public class DateScrollView: UIScrollView {
    
    weak var chooseDelegate: DateScrollViewChooseDateItemDalegate?
    
    fileprivate var chooseDate = Date()
    fileprivate lazy var lastOffset: CGFloat = {
        return self.bounds.size.width
    }()
    fileprivate var firstDate = Date()
    fileprivate var lastDate = Date()
    fileprivate lazy var toDay: Date = {
        return Date()
    }()
    
    fileprivate lazy var leftDateView: DateView = {
        let dateView = DateView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height),
                                weekLabelColor: self.weekLabelColor, dayLabelColor: self.dayLabelColor,
                                maskViewColor: self.maskViewColor, maskViewAlpha: self.maskViewAlpha)
        return dateView
    }()
    
    fileprivate lazy var midDateView: DateView = {
        let dateView = DateView(frame:  CGRect(x: self.bounds.size.width, y: 0, width: self.bounds.size.width, height: self.bounds.size.height),
                                weekLabelColor: self.weekLabelColor, dayLabelColor: self.dayLabelColor,
                                maskViewColor: self.maskViewColor, maskViewAlpha: self.maskViewAlpha)
        dateView.delegate = self
        return dateView
    }()
    
    fileprivate lazy var rightDateView: DateView = {
        let dateView = DateView(frame: CGRect(x: self.bounds.size.width * 2, y: 0, width: self.bounds.size.width, height: self.bounds.size.height),
                                weekLabelColor: self.weekLabelColor, dayLabelColor: self.dayLabelColor,
                                maskViewColor: self.maskViewColor, maskViewAlpha: self.maskViewAlpha)
        return dateView
    }()
    
    fileprivate var weekLabelColor = UIColor.black
    fileprivate var dayLabelColor = UIColor.black
    fileprivate var maskViewColor = UIColor.black
    fileprivate var maskViewAlpha: CGFloat = 0.4
    
    
    /// 初始化时间选择器
    ///
    /// - Parameters:
    ///   - frame: 控件的frame
    ///   - weekLabelColor: 显示周的label的字体颜色 默认为黑色
    ///   - dayLabelColor: 显示日期的label的字体颜色 默认为黑色
    ///   - maskViewColor: 选中时日期时给item加上一个选中样式，选中样式的颜色 默认为黑色
    ///   - maskViewAlpha: 选中样式图层的透明度 默认透明度为0.4
    init(frame: CGRect, weekLabelColor: UIColor = UIColor.black, dayLabelColor: UIColor = UIColor.black, maskViewColor: UIColor = UIColor.black, maskViewAlpha: CGFloat = 0.4) {
        super.init(frame: frame)
        self.weekLabelColor = weekLabelColor
        self.dayLabelColor = dayLabelColor
        self.maskViewColor = maskViewColor
        self.maskViewAlpha = maskViewAlpha
        initSetting()
        
        self.addSubview(leftDateView)
        self.addSubview(midDateView)
        self.addSubview(rightDateView)
        
        initMidDateView()
        initLeftDateView()
        initRightDateView()
    }
    
    private func initSetting() {
        self.contentSize = CGSize(width: self.bounds.size.width * 3, height: self.bounds.size.height)
        self.contentOffset = CGPoint(x: self.bounds.size.width, y: 0)
        self.isPagingEnabled = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.bounces = false
        self.layer.masksToBounds = true
        self.delegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 初始化midDateView
    func initMidDateView() {
        let compontes = getTodayWeek(date: toDay)
        for i in 0..<midDateView.subviews.count {
            guard let dateViewItem = midDateView.subviews[i] as? DateViewItem else { return }
            let date = theDayWithOneDay(numberOfDays: (i + 1) - compontes.0, date: toDay)
            if i == 0 {
                firstDate = date
            } else if i == midDateView.subviews.count - 1 {
                lastDate = date
            }
            let componte = getTodayWeek(date: date)
            dateViewItem.setWeeklabelText(text: weekArrayOfEnglish[componte.0 - 1])
            dateViewItem.setItemDate(date: date)
            if date == toDay {
                dateViewItem.setDateLabelText(text: "今")
            } else {
                dateViewItem.setDateLabelText(text: "\(componte.1)")
            }
        }
    }
    
    
    /// 初始化leftDateView
    func initLeftDateView() {
        for i in 0..<leftDateView.subviews.count {
            guard let dateViewItem = leftDateView.subviews[i] as? DateViewItem else { return }
            let date = theDayWithOneDay(numberOfDays: -(7 - i), date: firstDate)
            let componte = getTodayWeek(date: date)
            dateViewItem.setWeeklabelText(text: weekArrayOfEnglish[componte.0 - 1])
            dateViewItem.setItemDate(date: date)
            dateViewItem.setDateLabelText(text: "\(componte.1)")
        }
    }
    
    
    /// 初始化rightDateView()
    func initRightDateView() {
        for i in 0..<rightDateView.subviews.count {
            guard let dateViewItem = rightDateView.subviews[i] as? DateViewItem else { return }
            let date = theDayWithOneDay(numberOfDays: i + 1, date: lastDate)
            let componte = getTodayWeek(date: date)
            dateViewItem.setWeeklabelText(text: weekArrayOfEnglish[componte.0 - 1])
            dateViewItem.setItemDate(date: date)
            dateViewItem.setDateLabelText(text: "\(componte.1)")
        }
    }
    
    /// 计算某天是星期几，是当前月的第几天
    ///
    /// - Parameter date: 要计算的那一天
    /// - Returns: 返回值为元组，0为星期几,1为当前月的第几天
    func getTodayWeek(date: Date) -> (Int, Int) {
        let component = NSCalendar.current.dateComponents([.weekday, .day], from: date)
        var weekDay = 0
        switch (component.weekday ?? 0) {
        case 2...7:
            weekDay = (component.weekday ?? 1) - 1
        default:
            weekDay = 7
        }
        
        return (weekDay,component.day ?? 0)
    }
    
    /// 计算距离今天前/后几天的某一天
    ///
    /// - Parameter numberOfDays: 距离今天有几天
    /// - Returns: 距离今天前/后numberOfDays的那天
    func theDayWithOneDay(numberOfDays: Int, date: Date) -> Date {
        let secondsOfDay: TimeInterval = 60 * 60 * 24
        return date.addingTimeInterval(TimeInterval(numberOfDays) * secondsOfDay)
    }
    
    /// 滑动scrollView时作处理
    ///
    /// - Parameter direction: 0 为向右滑， 1为向左滑(手指移动的方向)
    func scrolToLeftOrRight(direction: Int) {
        print("\(#function),\(direction)")
        
        if direction != 0 && direction != 1 {
            return
        }
        caculateMidDateView(direction: direction)
        self.contentOffset = CGPoint(x: self.bounds.size.width, y: 0)
    }
    
    func caculateMidDateView(direction: Int) {
        var caculateFirstDate = Date()
        var caculateLastDate = Date()
        
        for i in 0..<midDateView.subviews.count {
            guard let dateViewitem = midDateView.subviews[i] as? DateViewItem else { return }
            var date = Date()
            if direction == 1 {
                date = theDayWithOneDay(numberOfDays: (i + 1), date: lastDate)
            } else {
                date = theDayWithOneDay(numberOfDays: -(7 - i), date: firstDate)
            }
            let component = getTodayWeek(date: date)
            dateViewitem.setWeeklabelText(text: weekArrayOfEnglish[component.0 - 1])
            dateViewitem.isChooseed = false
            if date == chooseDate {
                dateViewitem.isChooseed = true
            }
            dateViewitem.setItemDate(date: date)
            dateViewitem.setDateLabelText(text: "\(component.1)")
            if date == toDay {
                dateViewitem.setDateLabelText(text: "今")
            }
            if i == 0 {
                caculateFirstDate = date
            } else if i == 6 {
                caculateLastDate = date
            }
        }
        
        firstDate = caculateFirstDate
        lastDate = caculateLastDate
        initLeftDateView()
        initRightDateView()
    }
    
}

extension DateScrollView: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if lastOffset == scrollView.contentOffset.x {
            return
        } else {
            if lastOffset < scrollView.contentOffset.x {
                scrolToLeftOrRight(direction: 1)
            } else {
                scrolToLeftOrRight(direction: 0)
            }
            lastOffset = scrollView.contentOffset.x
        }
    }
    
}

extension DateScrollView : DateViewDalegate {
    
    func getNormlDate(date: Date) {
        chooseDelegate?.getNormlDate(date: date)
        chooseDate = date
        midDateView.subviews.forEach({
           guard  let dateViewItem = $0 as? DateViewItem else { return }
            if dateViewItem.getItemDate() != date {
                dateViewItem.isChooseed = false
            } else {
                dateViewItem.isChooseed = true
            }
        })
    }
    
    func getLocationGMTDate(date: Date) {
        chooseDelegate?.getLocationGMTDate(date: date)
    }
    
    func getDateInto(dateInfo: (Int, Int, Int, Int)) {
        chooseDelegate?.getDateInto(dateInfo: dateInfo)
    }
    
}
