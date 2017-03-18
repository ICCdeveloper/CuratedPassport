//
//  CPLocaViewCell.swift
//  CuratedPassport
//
//  Created by SiliconZou on 2017/3/18.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPLocaViewCell: UITableViewCell {

    @IBOutlet weak var visaLabel1: UILabel!
    
    @IBOutlet weak var visaLabel2: UILabel!
    
    @IBOutlet weak var visaLabel3: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        visaLabel1.backgroundColor = UIColor.white
        visaLabel1.layer.cornerRadius = 3
        visaLabel1.layer.masksToBounds = true
        visaLabel1.layer.borderColor = UIColor.black.cgColor
        visaLabel1.layer.borderWidth = 1
        
        visaLabel2.backgroundColor = UIColor.white
        visaLabel2.layer.cornerRadius = 3
        visaLabel2.layer.masksToBounds = true
        visaLabel2.layer.borderWidth = 1
        visaLabel2.layer.borderColor = UIColor.black.cgColor
        
        visaLabel3.backgroundColor = UIColor.white
        visaLabel3.layer.cornerRadius = 3
        visaLabel3.layer.masksToBounds = true
        visaLabel3.layer.borderColor = UIColor.black.cgColor
        visaLabel3.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
