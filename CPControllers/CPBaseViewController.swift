//
//  CPBaseViewController.swift
//  CuratedPassport
//
//  Created by SiliconZou on 2017/3/25.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let backBtn = UIButton.init(frame: CGRect.init(x: 0, y: SCREEN_H - 40, width: SCREEN_W, height: 40))
        backBtn.backgroundColor = UIColor.magenta
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.view.addSubview(backBtn)
    }
    
    func backBtnClick() {
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
