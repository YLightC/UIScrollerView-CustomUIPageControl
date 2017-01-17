//
//  DateView.swift
//  Banner
//
//  Created by yaosixu on 2017/1/17.
//  Copyright © 2017年 Jason_Yao. All rights reserved.
//

import UIKit

protocol DateViewDalegate: class {
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

class DateView: UIView {
    
    weak var delegate: DateViewDalegate?
    
    private var itemCount = 7
    fileprivate var weekLabelColor = UIColor.black
    fileprivate var dayLabelColor = UIColor.black
    fileprivate var maskViewColor = UIColor.black
    fileprivate var maskViewAlpha: CGFloat = 0.4
    
    init(frame: CGRect, weekLabelColor: UIColor = UIColor.black, dayLabelColor: UIColor = UIColor.black, maskViewColor: UIColor = UIColor.black, maskViewAlpha: CGFloat = 0.4) {
        super.init(frame: frame)
        self.weekLabelColor = weekLabelColor
        self.dayLabelColor = dayLabelColor
        self.maskViewColor = maskViewColor
        self.maskViewAlpha = maskViewAlpha
        
        addDateViewItem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addDateViewItem() {
        let itemWidth = self.bounds.size.width / CGFloat(itemCount)
        for i in 0..<itemCount {
            let dateViewItem = DateViewItem(frame: CGRect(x: CGFloat(i) * itemWidth, y: 0, width: itemWidth, height: self.bounds.size.height),
                                            weekLabelColor: self.weekLabelColor, dayLabelColor: self.dayLabelColor,
                                            maskViewColor: self.maskViewColor, maskViewAlpha: self.maskViewAlpha)
            dateViewItem.delegate = self
            dateViewItem.setWeeklabelText(text: weekArrayOfEnglish[i])
            dateViewItem.setDateLabelText(text: "\(i)")
            self.addSubview(dateViewItem)
        }
    }
    
}

extension DateView : DateViewItemDelegate {
    
    func getNormlDate(date: Date) {
        delegate?.getNormlDate(date: date)
    }
    
    func getLocationGMTDate(date: Date) {
        delegate?.getLocationGMTDate(date: date)
    }
    
    func getDateInto(dateInfo: (Int, Int, Int, Int)) {
        delegate?.getDateInto(dateInfo: dateInfo)
    }
    
}
