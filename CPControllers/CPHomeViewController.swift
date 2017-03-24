//
//  CPHomeViewController.swift
//  CuratedPassport
//
//  Created by ICCorg on 2017/3/11.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPHomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var bgView : UITableView!
    var bg : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        bgView = UITableView.init(frame: CGRect.init(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height))
        self.view.addSubview(bgView)
        bgView.delegate = self
        bgView.dataSource = self
        bgView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        bgView.separatorStyle = UITableViewCellSeparatorStyle.none
        bgView.register(UINib.init(nibName: "CPMagazineViewCell", bundle: nil), forCellReuseIdentifier: "CPMagazineViewCell")
        bgView.register(UINib.init(nibName: "CPInfoViewCell", bundle: nil), forCellReuseIdentifier: "CPInfoViewCell")
        bgView.register(UINib.init(nibName: "CPNotifyViewCell", bundle: nil), forCellReuseIdentifier: "CPNotifyViewCell")
        bgView.register(UINib.init(nibName: "CPLocaViewCell", bundle: nil), forCellReuseIdentifier: "CPLocaViewCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        bg = self.scrollView(view: self.view)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 240
        } else if indexPath.section == 1 {
            return 100
        } else if indexPath.section == 2 {
            return 40
        } else {
            return 100
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 0
        } else if section == 1 {
            return 0
        }
        return 30
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let valueNum = bgView.contentSize.height - UIScreen.main.bounds.size.height
        if scrollView.isKind(of: UITableView.classForCoder()) {
            if offsetY - valueNum > 30 {
                let testVC = CPTestViewController()
                self.navigationController?.pushViewController(testVC, animated: true)
                testVC.bgImg = bg
            }
        }
    }
    
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
