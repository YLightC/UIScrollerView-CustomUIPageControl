//
//  DateViewItem.swift
//  Banner
//
//  Created by yaosixu on 2017/1/17.
//  Copyright © 2017年 Jason_Yao. All rights reserved.
//

import UIKit

protocol DateViewItemDelegate: class {
    
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

class DateViewItem: UIView {
    
    weak var delegate: DateViewItemDelegate?
    var isChooseed: Bool = false {
        didSet {
            if isChooseed {
                customMaskView.isHidden = false
            } else {
                customMaskView.isHidden = true
            }
        }
    }
    
    fileprivate var weekLabelColor = UIColor.black
    fileprivate var dayLabelColor = UIColor.black
    fileprivate var maskViewColor = UIColor.black
    fileprivate var maskViewAlpha: CGFloat = 0.4
    
    fileprivate lazy var customMaskView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.frame = CGRect(x: 0, y: -self.bounds.size.height, width: self.bounds.size.width, height: 2 * self.bounds.size.height)
        view.layer.cornerRadius = self.bounds.size.width / 2
        view.backgroundColor = self.maskViewColor
        view.alpha = self.maskViewAlpha
        self.addSubview(view)
        return view
    }()
    
    fileprivate var itemDate = Date()
    fileprivate lazy var weekLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.sizeToFit()
        return label
    }()
    
    init(frame: CGRect, weekLabelColor: UIColor = UIColor.black, dayLabelColor: UIColor = UIColor.black, maskViewColor: UIColor = UIColor.black, maskViewAlpha: CGFloat = 0.4) {
        super.init(frame: frame)
        self.weekLabelColor = weekLabelColor
        self.dayLabelColor = dayLabelColor
        self.maskViewColor = maskViewColor
        self.maskViewAlpha = maskViewAlpha
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        let tapGestureAction = UITapGestureRecognizer(target: self, action: #selector(tapDateViewItemAction))
        self.addGestureRecognizer(tapGestureAction)
        addLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addLabel() {
        weekLabel.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height / 2)
        dateLabel.frame = CGRect(x: 0, y: self.bounds.size.height / 2, width: self.bounds.size.width, height: self.bounds.size.height / 2)
        weekLabel.textColor = weekLabelColor
        dateLabel.textColor = dayLabelColor
        
        self.addSubview(weekLabel)
        self.addSubview(dateLabel)
    }
    
    func setWeeklabelText(text: String) {
        weekLabel.text = text
    }
    
    func setDateLabelText(text: String) {
        dateLabel.text = text
    }
    
    func setItemDate(date: Date) {
        itemDate = date
    }
    
    func getItemDate() -> Date {
        return itemDate
    }
    
    @objc func tapDateViewItemAction() {
        isChooseed = true
        delegate?.getNormlDate(date: itemDate)
        delegate?.getLocationGMTDate(date: locationGMTDate())
        delegate?.getDateInto(dateInfo: theDateInfo())
    }
    
    fileprivate func locationGMTDate() -> Date {
        let zone = NSTimeZone.system
        let seconds = zone.secondsFromGMT(for: itemDate)
        return itemDate.addingTimeInterval(TimeInterval(seconds))
    }
    
    fileprivate func theDateInfo() -> (Int, Int, Int, Int) {
        let component = NSCalendar.current.dateComponents([.year, .month, .weekday, .day], from: itemDate)
        
        var weekDay = 0
        switch (component.weekday ?? 0) {
        case 2...7:
            weekDay = (component.weekday ?? 1) - 1
        default:
            weekDay = 7
        }
        
        return (component.year ?? 0, component.month ?? 0, weekDay, component.day ?? 0)
    }
}
