//
//  CPHomeViewController.swift
//  CuratedPassport
//
//  Created by ICCorg on 2017/3/11.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit
import CoreLocation

class CPHomeViewController: UIViewController {
    
    var bg : UIImage?
    //默认首页布局的tableview
    var homeTableView : UITableView!
    
    //懒加载底部的scrollview
    lazy var bgScrollView:UIScrollView = {
        
        let bgScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width:SCREEN_W , height: SCREEN_H))
        bgScrollView.isScrollEnabled = false
        bgScrollView.contentSize = CGSize.init(width: SCREEN_W, height: SCREEN_H*3)
        bgScrollView.backgroundColor = UIColor.lightText
        bgScrollView.setContentOffset(CGPoint.init(x: 0, y: SCREEN_H), animated: false)
        return bgScrollView
    
    }()
    
    //懒加载下拉出现的杂志详情
    lazy var magaWebView:UIWebView = {
    
        let magaWebView = UIWebView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H))
        return magaWebView
    
    }()
    
    //懒加载上滑出现的聚点信息
    lazy var localTableView:UITableView = {
        
        let localTableView = UITableView.init(frame: CGRect.init(x: 0, y: SCREEN_H*2 + 44, width: SCREEN_W, height: SCREEN_H - 44))
        localTableView.backgroundColor = UIColor.clear
        localTableView.delegate = self
        localTableView.dataSource = self
        //去除tableview底部多余的线条
        localTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        //取消cell之间的线条
        localTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        localTableView.register(UINib.init(nibName: "CPDetailViewCell", bundle: nil), forCellReuseIdentifier: "CPDetailViewCell")
        localTableView.register(UINib.init(nibName: "CPVisaViewCell", bundle: nil), forCellReuseIdentifier: "CPVisaViewCell")
        return localTableView
    
    }()
    
    //懒加载上拉时的返回按钮
    lazy var pullupBackBtn:UIButton = {
    
        let pullupBackBtn = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_H*2, width: SCREEN_W, height: 44))
        pullupBackBtn.backgroundColor = UIColor.magenta
        pullupBackBtn.alpha = 0.5
        pullupBackBtn.addTarget(self, action: #selector(pullupBackBtnClick), for: .touchUpInside)
        
        return pullupBackBtn
    }()
    
    //懒加载下拉时的返回按钮
    lazy var pulldownBackBtn:UIButton = {
    
        let pulldownBackBtn = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_H - 44, width: SCREEN_W, height: 44))
        pulldownBackBtn.backgroundColor = UIColor.magenta
        pulldownBackBtn.alpha = 0.5
        pulldownBackBtn.addTarget(self, action: #selector(pullupBackBtnClick), for: .touchUpInside)
        return pulldownBackBtn
    }()
    
    lazy var locateManager:CLLocationManager = {
    
        let locateM = CLLocationManager()
        locateM.delegate = self
        locateM.requestAlwaysAuthorization()
        if #available(iOS 9.0, *) {
            locateM.allowsBackgroundLocationUpdates = true
        }
        return locateM
    
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(bgScrollView)
        self.automaticallyAdjustsScrollViewInsets = false
        let item = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.createHomeTableView()
        self.bgScrollView.addSubview(homeTableView!)
        self.bgScrollView.addSubview(localTableView)
        self.bgScrollView.addSubview(magaWebView)
        self.bgScrollView.addSubview(pullupBackBtn)
        self.bgScrollView.addSubview(pulldownBackBtn)
        self.PullUp()
        self.PullUpBack()
        self.PullDown()
        self.PullDownBack()
        self.locateManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locateManager.startUpdatingLocation()
        
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            let center = CLLocationCoordinate2DMake(23.494725460208482, 113.19972395907453)
            var distance:CLLocationDistance = 0.1
//            if distance < locateManager.maximumRegionMonitoringDistance {
//                distance = locateManager.maximumRegionMonitoringDistance
//            }
            let region = CLCircularRegion.init(center: center, radius: distance, identifier: "id")
            self.locateManager.startMonitoring(for: region)
            self.locateManager.requestState(for: region)
        }
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.locateManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locateManager.startUpdatingLocation()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        bg = self.scrollView(view: self.view)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    //创建首页默认tableview
    func createHomeTableView() {
        homeTableView = UITableView.init(frame: CGRect.init(x: 0, y: SCREEN_H, width: SCREEN_W, height: SCREEN_H))
        homeTableView.delegate =  self
        homeTableView.dataSource = self
        homeTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        homeTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        homeTableView.register(UINib.init(nibName: "CPMagazineViewCell", bundle: nil), forCellReuseIdentifier: "CPMagazineViewCell")
        homeTableView.register(UINib.init(nibName: "CPInfoViewCell", bundle: nil), forCellReuseIdentifier: "CPInfoViewCell")
        homeTableView.register(UINib.init(nibName: "CPNotifyViewCell", bundle: nil), forCellReuseIdentifier: "CPNotifyViewCell")
        homeTableView.register(UINib.init(nibName: "CPLocaViewCell", bundle: nil), forCellReuseIdentifier: "CPLocaViewCell")
    }
    
    func pullupBackBtnClick() {
        
        self.bgScrollView.scrollRectToVisible(CGRect.init(x: 0, y: SCREEN_H, width: SCREEN_W, height: SCREEN_H), animated: true)
    }
    
//    func pulldownBackBtnClick() {
//        self.bgScrollView.scrollRectToVisible(CGRect.init(x: <#T##CGFloat#>, y: <#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>), animated: <#T##Bool#>)
//    }
    
    //下拉进入杂志时触发的操作
    func PullDown() {
        weak var weakSelf = self
        let pulldownHeader = MJRefreshNormalHeader.init { 
            weakSelf?.bgScrollView.scrollRectToVisible(CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H), animated: true)
            weakSelf?.homeTableView.mj_header.endRefreshing()
            weakSelf?.magaWebView.loadRequest(URLRequest.init(url: URL.init(string: "https://index.baidu.com")!))
        }
        pulldownHeader?.arrowView.image = nil
        pulldownHeader?.lastUpdatedTimeLabel.isHidden = true
        pulldownHeader?.setTitle("下拉进入该杂志", for: MJRefreshState.idle)
        pulldownHeader?.setTitle("释放到达杂志页", for: MJRefreshState.pulling)
        self.homeTableView.mj_header = pulldownHeader
    }
    
    //下拉返回首页时触发的操作
    func PullDownBack() {
        weak var weakSelf = self
        let pulldownFooter = MJRefreshBackNormalFooter.init {
            weakSelf?.bgScrollView.scrollRectToVisible(CGRect.init(x: 0, y: SCREEN_H, width: SCREEN_W, height: SCREEN_H), animated: true)
            weakSelf?.magaWebView.scrollView.mj_footer.endRefreshing()
        }
        pulldownFooter?.arrowView.image = nil
        self.magaWebView.scrollView.mj_footer = pulldownFooter
    }
    
    //上滑进入时触发的操作
    func PullUp() {
        weak var weakSelf = self
        let pullupFooter = MJRefreshBackNormalFooter.init { 
            weakSelf?.bgScrollView.scrollRectToVisible(CGRect.init(x: 0, y: SCREEN_H*2, width: SCREEN_W, height: SCREEN_H), animated: true)
            weakSelf?.homeTableView.mj_footer.endRefreshing()
        }
        pullupFooter?.arrowView.image = nil
        pullupFooter?.stateLabel.isHidden = true
        pullupFooter?.setTitle("上滑查看聚点详情", for: MJRefreshState.idle)
        pullupFooter?.setTitle("释放到达详情页", for: MJRefreshState.pulling)
        
        self.homeTableView.mj_footer = pullupFooter
    }
    
    //上滑返回首页时触发的操作
    func PullUpBack() {
        weak var weakSelf = self
        let pullupHeader = MJRefreshNormalHeader.init { 
            weakSelf?.bgScrollView.scrollRectToVisible(CGRect.init(x: 0, y: SCREEN_H, width: SCREEN_W, height: SCREEN_H), animated: true)
            weakSelf?.localTableView.mj_header.endRefreshing()
        }
        pullupHeader?.arrowView.image = nil
        pullupHeader?.setTitle("下拉返回首页", for: MJRefreshState.idle)
        pullupHeader?.setTitle("释放到达首页", for: MJRefreshState.pulling)
        pullupHeader?.lastUpdatedTimeLabel.isHidden = true
        self.localTableView.mj_header = pullupHeader
    }
    
    
    
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        let offsetY = scrollView.contentOffset.y
//        let valueNum = bgView.contentSize.height - UIScreen.main.bounds.size.height
//        if scrollView.isKind(of: UITableView.classForCoder()) {
//            if offsetY - valueNum > 30 {
//                let testVC = CPTestViewController()
//                self.navigationController?.pushViewController(testVC, animated: true)
//                testVC.bgImg = bg
//            }
//        }
//    }
    
    //截图
    func scrollView(view:UIView) -> UIImage {
        let rect = view.frame
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        view.layer.render(in: context!)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
        
    }

}
