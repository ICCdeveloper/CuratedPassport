//
//  CPInfoViewController.swift
//  CuratedPassport
//
//  Created by SiliconZou on 2017/3/24.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPInfoViewController: CPBaseViewController,UITableViewDelegate,UITableViewDataSource {

    var infoTableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.view.backgroundColor = UIColor.brown
        self.navigationItem.title = "个人信息"
        self.automaticallyAdjustsScrollViewInsets = false
        self.createUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    func createUI() {
        
        let item = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = item
        self.infoTableView = UITableView.init(frame: CGRect.init(x: 0, y: 64, width: SCREEN_W, height: SCREEN_H - 64 - 40))
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        infoTableView.separatorStyle = .none
        self.view.addSubview(infoTableView)
        infoTableView.register(UINib.init(nibName: "CPMyInfoViewCell", bundle: nil), forCellReuseIdentifier: "CPMyInfoViewCell")
        infoTableView.register(UINib.init(nibName: "CPMyVisaViewCell", bundle: nil), forCellReuseIdentifier: "CPMyVisaViewCell")
        infoTableView.register(UINib.init(nibName: "CPMyCourseViewCell", bundle: nil), forCellReuseIdentifier: "CPMyCourseViewCell")
        infoTableView.register(UINib.init(nibName: "CPMyViewCell", bundle: nil), forCellReuseIdentifier: "CPMyViewCell")
    }
    
    func MyFavBtnClick()  {
        self.navigationController?.pushViewController(CPMyFavouriteViewController(), animated: true)
    }
    
    func MyFocusBtnClick() {
        self.navigationController?.pushViewController(CPMyFocusViewController(), animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CPMyInfoViewCell", for: indexPath) as! CPMyInfoViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CPMyVisaViewCell", for: indexPath) as! CPMyVisaViewCell
            cell.selectionStyle = .none
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CPMyCourseViewCell", for: indexPath) as! CPMyCourseViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CPMyViewCell", for: indexPath) as! CPMyViewCell
            cell.selectionStyle = .none
            cell.myFavBtn.addTarget(self, action: #selector(MyFavBtnClick), for: .touchUpInside)
            cell.myFocusBtn.addTarget(self, action: #selector(MyFocusBtnClick), for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else if indexPath.section == 1 {
            return 300
        } else if indexPath.section == 2 {
            return 90
        } else {
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 0
        } else if section == 2 {
            return 0
        } else {
            return 0
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
