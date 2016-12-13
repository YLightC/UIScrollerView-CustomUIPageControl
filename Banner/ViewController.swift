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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        addTabelView()
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
    }
    
    func tapButtonAction() {
        guard let url = URL(string: "AboutURLSession://") else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
        pageControl.currentPage = imageIndex
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


