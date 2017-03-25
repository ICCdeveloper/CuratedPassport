//
//  CPHomeViewController.swift
//  CuratedPassport
//
//  Created by ICCorg on 2017/3/11.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPHomeViewController: CPBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
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
        
        let localTableView = UITableView.init(frame: CGRect.init(x: 0, y: SCREEN_H*2 + 44, width: SCREEN_W, height: SCREEN_H))
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
        self.PullUp()
        self.PullUpBack()
        self.PullDown()
    }
    
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
    
    //下拉触发的操作
    func PullDown() {
        weak var weakSelf = self
        let pulldownHeader = MJRefreshNormalHeader.init { 
            weakSelf?.bgScrollView.scrollRectToVisible(CGRect.init(x: 0, y: 0, width: SCREEN_W, height: SCREEN_H), animated: true)
            weakSelf?.homeTableView.mj_header.endRefreshing()
            weakSelf?.magaWebView.loadRequest(URLRequest.init(url: URL.init(string: "http://m.bing.com")!))
        }
        pulldownHeader?.arrowView.image = nil
        pulldownHeader?.lastUpdatedTimeLabel.isHidden = true
        pulldownHeader?.setTitle("下拉进入该杂志", for: MJRefreshState.idle)
        pulldownHeader?.setTitle("释放到达杂志页", for: MJRefreshState.pulling)
        self.homeTableView.mj_header = pulldownHeader
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
    
    
    //MARK:  tableview代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.isEqual(homeTableView) {
            return 4
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.isEqual(homeTableView) {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CPMagazineViewCell", for: indexPath) as! CPMagazineViewCell
                return cell
            } else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CPInfoViewCell", for: indexPath) as! CPInfoViewCell
                return cell
            } else if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CPNotifyViewCell", for: indexPath) as! CPNotifyViewCell
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CPLocaViewCell", for: indexPath) as! CPLocaViewCell
                return cell
            }
        } else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CPDetailViewCell", for: indexPath) as! CPDetailViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CPVisaViewCell", for: indexPath) as! CPVisaViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEqual(homeTableView) {
            
            if indexPath.section == 1 {
                
                let cpInfo = CPInfoViewController()
                //转场动画
                let transition = CATransition()
                
                //动画时间
                transition.duration = 0.8
                
                //动画方向（在某些类型的动画里会失效）
                transition.subtype = kCATransitionFromRight
                
                //动画类型
                transition.type = kCATransitionReveal
                
                transition.type = "rippleEffect"
                /*
                 fade moveIn push reveal	和系统预设的四种一样
                 pageCurl pageUnCurl		翻页
                 rippleEffect			滴水效果
                 suckEffect			收缩效果，如一块布被抽走
                 cube alignedCube		立方体效果
                 flip alignedFlip oglFlip		翻转效果
                 rotate				旋转
                 cameraIris cameraIrisHollowOpen cameraIrisHollowClose 相机
                 */
                
                self.navigationController?.view.layer.add(transition, forKey: nil)
                
                self.navigationController?.pushViewController(cpInfo, animated: false)
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView.isEqual(homeTableView) {

            if indexPath.section == 0 {
                return 240
            } else if indexPath.section == 1 {
                return 100
            } else if indexPath.section == 2 {
                return 40
            } else {
                return 100
            }
        } else {
            if indexPath.section == 0 {
                return 220
            } else {
                return 300
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView.isEqual(homeTableView) {
            if section == 3 {
                return 0
            } else if section == 1 {
                return 0
            }
            return 30
        } else {
            return 0
        }
        
        
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
