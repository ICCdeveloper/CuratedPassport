//
//  CPTestViewController.swift
//  CuratedPassport
//
//  Created by SiliconZou on 2017/3/19.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPTestViewController: UIViewController {

    var bgImg : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.green
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 64))
//        button.backgroundColor = UIColor.darkText
        let bottomBtn = UIButton.init(frame: CGRect.init(x: 0, y: UIScreen.main.bounds.size.height - 64, width: UIScreen.main.bounds.size.width, height: 64))
        bottomBtn.backgroundColor = UIColor.black
        button.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        self.view.backgroundColor = UIColor.init(patternImage: bgImg!)
        bottomBtn.addTarget(self, action: #selector(btnClick), for:.touchUpInside)
        self.view.addSubview(button)
        self.view.addSubview(bottomBtn)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func btnClick() {
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
