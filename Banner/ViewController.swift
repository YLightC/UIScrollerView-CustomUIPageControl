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
    let button: UIButton = UIButton()
    
    let tableView = UITableView()
    
    fileprivate var progressView: UIView = UIView()
    fileprivate var circleLayer: CAShapeLayer = CAShapeLayer()
    fileprivate var startAnimationButton: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        addProgressView()
        addCircleLayer(radius: 30, strokeColor: UIColor.white.cgColor)
        addStartAnimationButton()
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button.setImage(UIImage(named: "0"), for: .normal)
//        button.backgroundColor = UIColor.cyan
//        button.layer.cornerRadius = 25
//        let maskLayer = CALayer()
//        maskLayer.frame = button.bounds
//        maskLayer.backgroundColor = UIColor.white.cgColor
//        maskLayer.cornerRadius = 25
//        button.layer.mask = maskLayer

//        button.layer.shadowColor = UIColor.black.cgColor
//        button.layer.shadowOffset = CGSize(width: 0, height: 10)
//        button.layer.shadowOpacity = 0.6
//        self.view.addSubview(button)
        
//        let maskLayer = CAShapeLayer()
//        let bezierPath = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 50)
//        maskLayer.path = bezierPath.cgPath
//        maskLayer.fillColor = UIColor.white.cgColor
//        imageView.layer.mask = maskLayer
//        self.view.addSubview(imageView)
//        
//        let cornerRadiusLayer = CAShapeLayer()
//        let bezierPath = UIBezierPath(roundedRect: imageView.bounds, cornerRadius: 50)
//        cornerRadiusLayer.path = bezierPath.cgPath
//        cornerRadiusLayer.fillColor = UIColor.white.cgColor
//        imageView.layer.mask = cornerRadiusLayer
        
//        let view = UIView(frame: CGRect(x: 100, y: 500, width: 100, height: 100))
//        view.backgroundColor = UIColor.cyan
//        view.layer.cornerRadius = 50
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 10)
//        view.layer.shadowOpacity = 0.6
//        self.view.addSubview(view)
        
//        let button = ImageAtRightButton()
//        button.frame.origin = CGPoint(x: 100, y: 400)
//        button.setTitle("123", for: .normal)
//        button.setImage(UIImage(named: "播放"), for: .normal)
//        button.backgroundColor = UIColor.cyan
//        button.sizeToFit()
//        view.addSubview(button)
//        addTabelView()
//        let bannerFrame = CGRect(x: 0, y: 100, width: self.view.bounds.size.width, height: 200)
//        let bannerSocrller = BannerScrollView(frame: bannerFrame, startIndex: 0, imageNameArray: imageNameArray)
//        bannerSocrller.bannerScorllerDelegate = self
//        bannerSocrller.time = 2.5
//        bannerSocrller.isAutoScrollerWithTime = true
//        view.addSubview(bannerSocrller)
//        addPageControl()
//        button.frame = CGRect(x: 100, y: 100, width: 100, height: 30)
//        button.setTitle("tap Me!", for: .normal)
//        button.setTitleColor(UIColor.white, for: .normal)
//        button.backgroundColor = UIColor.black
//        button.addTarget(self, action: #selector(tapButtonAction), for: .touchUpInside)
//        view.addSubview(button)
//        view.isMultipleTouchEnabled = true
//        
//        customViewA.frame = CGRect(x: 0, y: 50, width: view.bounds.size.width, height: 200)
//        customViewA.backgroundColor = UIColor.red
//        customViewA.isExclusiveTouch = true
//        view.addSubview(customViewA)
//        
//        
//        customViewB.frame = CGRect(x: 0, y: 300, width: view.bounds.size.width, height: 200)
//        customViewB.backgroundColor = UIColor.yellow
//        view.addSubview(customViewB)
//        
//        customViewC.frame = CGRect(x: 0, y: 550, width: view.bounds.size.width, height: 100)
//        customViewC.backgroundColor = UIColor.green
//        view.addSubview(customViewC)
        
//        let imageView = UIImageView(frame: view.bounds)
//        imageView.image = UIImage(named: "3")
//        view.addSubview(imageView)
        
//        let circleRadius: CGFloat = 900
//        let offsetY: CGFloat = 130
//        let originX: CGFloat = -(circleRadius - view.bounds.size.width) / 2
//        let originY: CGFloat = -(circleRadius - offsetY)
//        let point = CGPoint(x: originX, y: originY)
//        let circleSize = CGSize(width: circleRadius, height: circleRadius)
//        
//        let frame = CGRect(origin: point, size: circleSize)
//        let gradientLayer: CAGradientLayer = CAGradientLayer()
//        gradientLayer.frame = frame
//        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
//        gradientLayer.locations = [0.0,1.0]
//        gradientLayer.cornerRadius = min(circleSize.width / 2, circleSize.height / 2)
//        gradientLayer.masksToBounds = true
//        view.layer.addSublayer(gradientLayer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let touchView = touches.first?.view ?? UIView()
        print("\(touchView.frame)")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touchView = touches.first?.view ?? UIView()
        print("\(touchView.frame)")
    }
    
    func tapButtonAction() {
        guard let url = URL(string: "AboutURLSession://") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        } else {
            print("can not open this Url")
        }
    }//JasonYaoSiXu
    
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
//        pageControl.currentPage = imageIndex
    }
}


extension ViewController {
    
    func addTabelView() {
        tableView.frame = view.bounds
        tableView.tableFooterView = UIView()
        tableView.register(CustomSwipeTableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.delegate = self
        tableView.dataSource = self
        let imageView = UIImageView()
        view.addSubview(tableView)
    }
    
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? CustomSwipeTableViewCell else {
            return UITableViewCell()
        }
        let button1 = UIButton()
        button1.setTitle("button1", for: .normal)
        button1.setTitleColor(UIColor.white, for: .normal)
        button1.backgroundColor = UIColor.black
//        let button2 = UIButton()
//        button2.setTitle("button2", for: .normal)
        cell.buttonArray = [button1]
        cell.buttonActionArray = [nil]
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}



open class ImageAtRightButton: UIButton {
    
    private var originImageSize = CGSize.zero
    private var showImageSize = CGSize.zero
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func setImage(_ image: UIImage?, for state: UIControlState) {
        super.setImage(image, for: state)
        originImageSize = image?.size ?? CGSize.zero
        print("\(#function),imageSize = \(originImageSize)")
    }
    
    override open func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        print("\(#function)")
        super.titleRect(forContentRect: contentRect)
        let contentSize = contentRect.size
        let height: CGFloat = contentSize.height
        let width: CGFloat = contentSize.width - showImageSize.width
        
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    override open func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        print("\(#function)")
        super.imageRect(forContentRect: contentRect)
        let contentSize = contentRect.size
        if originImageSize.width >= originImageSize.height {
            showImageSize = CGSize(width: originImageSize.height * 0.6, height: originImageSize.height * 0.6)
        } else {
            let rate = originImageSize.height / originImageSize.width
            showImageSize = CGSize(width: contentSize.height * 0.6 / rate, height: contentSize.height * 0.6)
        }
        
        return CGRect(x: contentSize.width - showImageSize.width, y: contentSize.height * 0.2, width: showImageSize.width, height: showImageSize.height)
    }
}

extension UIImage {
    
    func cornerImage(size: CGSize) -> UIImage? {
        let images = self
        print("images = \(images)")
        UIGraphicsBeginImageContext(size)
        guard let gc = UIGraphicsGetCurrentContext() else {  return nil }
        let radius = size.width / 2
        gc.concatenate(gc.ctm)
        gc.addArc(center: CGPoint(x: radius, y: radius), radius: radius, startAngle: 1.5 *  3.14, endAngle:  1.5 * -3.14, clockwise: true)
        gc.closePath()
        gc.clip()
        gc.draw(self.cgImage!, in: CGRect(origin: CGPoint(x: 0, y: 0), size: size))
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    func fixOrientation() -> UIImage? {
        print("-----> \(#function)")
        if self.imageOrientation == .up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        
        switch self.imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
            transform = transform.rotated(by: CGFloat(M_PI))
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.rotated(by: CGFloat(M_PI_2))
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: self.size.height)
            transform = transform.rotated(by: -CGFloat(M_PI_2))
        default:
            print("1 is normal")
        }
        
        switch self.imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: self.size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: self.size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        default:
            print("2 is normal")
        }
        
        guard let cgImage = self.cgImage else { return nil }
        
        guard let ctx = CGContext.init(data: nil, width: Int(self.size.width), height: Int(self.size.height),
                                 bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0,
                                 space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue) else { return nil }
        
        ctx.concatenate(transform)
        switch self.imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
        default:
            ctx.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: self.size))
        }
        
        guard let cgImg = ctx.makeImage() else { return nil }
        let img = UIImage(cgImage: cgImg)
        return img
    }
}

extension ViewController : CAAnimationDelegate {
    
    func addProgressView() {
        let width = self.view.bounds.size.width
        progressView.frame = CGRect(x: 0, y: 200, width: width, height: 300)
        progressView.backgroundColor = UIColor.cyan
        self.view.addSubview(progressView)
    }
    
    func createCircleRightLayer(radius: CGFloat) -> CGPath {
        let rect = CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2)
        let bezierPath = UIBezierPath(roundedRect: rect, cornerRadius: radius)
        bezierPath.move(to: CGPoint(x: radius * 0.3 , y: radius ))
        bezierPath.addLine(to: CGPoint(x: radius, y: radius * 1.5 ))
        bezierPath.addLine(to: CGPoint(x: radius * 1.7, y:  radius * 0.6))
        return bezierPath.cgPath
    }
    
    func createLineLayerPath(startPoint: CGPoint, endPoint: CGPoint) -> CGPath {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: startPoint)
        bezierPath.addLine(to: endPoint)
        return bezierPath.cgPath
    }
    
    func addCircleLayer(radius: CGFloat, strokeColor: CGColor?, fillColor: CGColor? = UIColor.clear.cgColor) {
        circleLayer.fillColor = fillColor
        circleLayer.lineWidth = 2
        circleLayer.strokeColor = strokeColor
        circleLayer.path = createCircleRightLayer(radius: radius)
        circleLayer.position = CGPoint(x: progressView.bounds.size.width / 2 - radius, y: progressView.bounds.size.height / 2 - radius)
        progressView.layer.addSublayer(circleLayer)
    }
    
    func addStartAnimationButton() {
        startAnimationButton.setTitle("Start", for: .normal)
        startAnimationButton.setTitleColor(UIColor.white, for: .normal)
        startAnimationButton.setTitleColor(UIColor.gray, for: .disabled)
        startAnimationButton.backgroundColor = UIColor.black
        startAnimationButton.sizeToFit()
        startAnimationButton.addTarget(self, action: #selector(tapStartAnimationButtonAction), for: .touchUpInside)
        startAnimationButton.frame.origin = CGPoint(x: 100, y: 600)
        self.view.addSubview(startAnimationButton)
    }
 
    func tapStartAnimationButtonAction() {
//        startAnimationButton.isEnabled = false
//        circleToLineAnimation()
//        print("\(#function)")
        self.navigationController?.pushViewController(DateViewController(), animated: true)
    }
    
//    func curvePath() -> CGPath {
//        
//    }
    
    func circleToLineAnimation() {
        let layerAnimation = CABasicAnimation(keyPath: "path")
        layerAnimation.duration = 1.5
        layerAnimation.delegate = self
        layerAnimation.toValue = createLineLayerPath(startPoint: CGPoint(x: 100, y: 150), endPoint: CGPoint(x: self.progressView.bounds.size.width - 200, y: 150))
        circleLayer.add(layerAnimation, forKey: "path")
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        print("\(#function)")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if (anim as? CABasicAnimation)?.keyPath == "path" {
            startAnimationButton.isEnabled = true
            print("\(#function)")
        }
    }
    
}
