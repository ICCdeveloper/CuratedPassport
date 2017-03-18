//
//  CPNotifyViewCell.swift
//  CuratedPassport
//
//  Created by SiliconZou on 2017/3/18.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPNotifyViewCell: UITableViewCell {

    @IBOutlet weak var notifyView: UIView!
    var notiFrView : CycleScrollView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        notiFrView = CycleScrollView.init(frame: CGRect.init(x: 0, y: 0, width: self.notifyView.frame.width, height: self.notifyView.frame.height), animationDuration: 1.0)
        let viewsArr = NSMutableArray.init()
        let arr = ["Si","Li","Con","Zou"]
        for _ in 0...arr.count {
            for si in arr {
                let label = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: notifyView.frame.width, height: notifyView.frame.height))
                label.text = NSString.init(format: "%@", si) as String
                label.textAlignment = .center
                label.textColor = UIColor.darkText
                label.font = UIFont.systemFont(ofSize: 20)
                viewsArr.add(label)
            }
        }
        self.notiFrView.backgroundColor = UIColor.lightGray
        self.notiFrView.fetchContentViewAtIndex = { (pageIndex) in
            
            return viewsArr[pageIndex] as? UIView
        }
        
        self.notiFrView.totalPagesCount = {
            
            return viewsArr.count
        }
        
        self.notifyView.addSubview(notiFrView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
