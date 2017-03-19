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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "CP"
        self.automaticallyAdjustsScrollViewInsets = false
        bgView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height))
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else if indexPath.section == 1 {
            return 200
        } else if indexPath.section == 2 {
            return 60
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 3 {
            return 0
        }
        return 10
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let valueNum = bgView.contentSize.height - UIScreen.main.bounds.height
        if offsetY - valueNum > 30 {
            
            self.navigationController?.pushViewController(CPTestViewController(), animated: true)
        }
    }

}
