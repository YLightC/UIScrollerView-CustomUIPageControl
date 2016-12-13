//
//  CustomSwipeTableViewCell.swift
//  Banner
//
//  Created by yaosixu on 2016/12/8.
//  Copyright © 2016年 Jason_Yao. All rights reserved.
//

import UIKit

///添加子视图必须添加到 myContentView
class CustomSwipeTableViewCell: UITableViewCell {

    let myContentView = UIView()
    /// button的默认宽度是100，可以通过buttonWidth设置
    var buttonArray: [UIButton] = [] {
        didSet {
            if buttonWidth * CGFloat(buttonArray.count) > UIScreen.main.bounds.size.width {
                buttonWidth = UIScreen.main.bounds.size.width / CGFloat(buttonArray.count)
            }
            addButton()
        }
    }
    
    var contentViewBackgroundColor: UIColor = UIColor.red {
        didSet {
            myContentView.backgroundColor = contentViewBackgroundColor
        }
    }
    
    var buttonActionArray: [((Void) -> Void)?] = []
    var buttonWidth: CGFloat = 100
    
    private var startPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var lastPoint: CGPoint = CGPoint(x: 0, y: 0)
    private var elasticityWidth: CGFloat = 40
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .none
        self.focusStyle = .custom
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
        // Configure the view for the selected state
    }
    
    private func addButton() {
        let width = UIScreen.main.bounds.size.width
        let height = self.bounds.size.height - 1
        
        for i in 0..<buttonArray.count {
            let buttonItem = buttonArray[i]
            buttonItem.frame = CGRect(x: width - CGFloat(buttonArray.count - i) * buttonWidth, y: 0, width: buttonWidth, height: height)
            buttonItem.tag = i
            self.addSubview(buttonItem)
            buttonItem.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        }
        addContentView()
    }
    
    private func addContentView() {
        let contentViewSize = CGSize(width: UIScreen.main.bounds.size.width, height: contentView.bounds.size.height)
        myContentView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: contentViewSize)
        self.contentView.backgroundColor = buttonArray.first?.backgroundColor
        myContentView.backgroundColor = contentViewBackgroundColor
        self.addSubview(myContentView)
        
        let panContentView = UIPanGestureRecognizer(target: self, action: #selector(panContentViewAction))
        panContentView.delegate = self
        myContentView.addGestureRecognizer(panContentView)
    }
    
    @objc private func panContentViewAction(panAction: UIPanGestureRecognizer) {
        let point = panAction.translation(in: self.myContentView)
        var moveX: CGFloat = 0
        if panAction.state == .began {
            startPoint = point
        } else if panAction.state == .changed {
            if myContentView.frame.origin.x > -(buttonWidth * CGFloat(buttonArray.count)) &&  myContentView.frame.origin.x <= 0 {
                lastPoint.x -= point.x
                if myContentView.frame.origin.x - lastPoint.x < -(buttonWidth * CGFloat(buttonArray.count)) {
                    moveX = -(buttonWidth * CGFloat(buttonArray.count))
                } else {
                    moveX = myContentView.frame.origin.x - lastPoint.x
                    if moveX > 0 {
                        moveX = 0
                    }
                }
                panAnimation(duringTime: 0.1, targetView: myContentView, offSetX: moveX)
            } else if myContentView.frame.origin.x <= -(buttonWidth * CGFloat(buttonArray.count)) && myContentView.frame.origin.x >= -(buttonWidth * CGFloat(buttonArray.count) + elasticityWidth) {
                lastPoint.x -= point.x
                moveX = myContentView.frame.origin.x - lastPoint.x / 3
                if moveX < -(buttonWidth * CGFloat(buttonArray.count) + elasticityWidth) {
                    moveX = -(buttonWidth * CGFloat(buttonArray.count) + elasticityWidth)
                }
                panAnimation(duringTime: 0.1, targetView: myContentView, offSetX: moveX)
            }
        } else if panAction.state == .ended {
            if (lastPoint.x - startPoint.x >= (buttonWidth * CGFloat(buttonArray.count)) / 2) {
                moveX = 0
            } else if lastPoint.x - startPoint.x <= -(buttonWidth * CGFloat(buttonArray.count)) / 2 {
                moveX = -(buttonWidth * CGFloat(buttonArray.count))
            } else {
                if startPoint.x > lastPoint.x {
                    moveX = 0
                } else if startPoint.x < lastPoint.x {
                    moveX = -(buttonWidth * CGFloat(buttonArray.count))
                }
            }
            panAnimation(duringTime: 0.2, targetView: myContentView, offSetX: moveX)
        } else {
            panAnimation(duringTime: 0.3, targetView: myContentView, offSetX: 0)
        }
        lastPoint = point
    }
    
    ///点击自定义按钮后cell恢复原状
    @objc private func tapButton(button: UIButton) {
        print("\(#function),button.tag = \(button.tag)")
        buttonActionArray[button.tag]?()
        panAnimation(duringTime: 0.3, targetView: myContentView, offSetX: 0)
    }
    
    //点击cell时触发
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if haveOffsetCell(gestureRecognizer: gestureRecognizer) {
            return false
        }
        return true
    }
    
    //开始滑动时触发
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panAction = gestureRecognizer as? UIPanGestureRecognizer else {
            return true
        }
        
        let point = panAction.translation(in: myContentView)
        if fabs(point.y - startPoint.y) > 2 {
            return false
        }
        return true
    }
    
    ///判断当前tableView显示的cell中，有没有发生偏移的
    private func haveOffsetCell(gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let tableView = findSuperViewIsUITableView(gestureRecognizer: gestureRecognizer) else {
            return false
        }
        
        guard let visalCells = tableView.visibleCells as? [CustomSwipeTableViewCell] else {
            return false
        }
        
        for visalCellsItem in visalCells {
            if visalCellsItem.myContentView.frame.origin.x < 0 {
                return true
            }
        }
        return false
    }
    
    ///找出当前cell所在的UITableView
    private func findSuperViewIsUITableView(gestureRecognizer: UIGestureRecognizer) -> UITableView? {
        guard let view = gestureRecognizer.view else {
            return nil
        }
        var cellSuperView: UIView? = view
        while cellSuperView != nil {
            if (cellSuperView?.isKind(of: UITableView.self))! {
                return cellSuperView as? UITableView
            }
            cellSuperView = cellSuperView?.superview
        }
        return nil
    }
    
}

///cell 滑动动画
fileprivate func panAnimation(duringTime: TimeInterval, targetView: UIView, offSetX: CGFloat) {
    DispatchQueue.main.async {
        UIView.animate(withDuration: duringTime, animations: {
            targetView.frame.origin.x = offSetX
        })
    }
}

extension UITableView : UIGestureRecognizerDelegate {
    
    //如果当前有cell发生了偏移，再次滑动cell的时候应该阻塞cell的滑动动作，以及tableView的滑动动作
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard let visalCells = self.visibleCells as? [CustomSwipeTableViewCell] else {
            return true
        }
        
        var result = true
        for item in visalCells {
            if item.myContentView.frame.origin.x < 0 {
                result = false
                panAnimation(duringTime: 0.3, targetView: item.myContentView, offSetX: 0)
            }
        }
        
        return result
    }
}
