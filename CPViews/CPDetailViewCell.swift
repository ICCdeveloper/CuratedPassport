//
//  CPDetailViewCell.swift
//  CuratedPassport
//
//  Created by SiliconZou on 2017/3/25.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPDetailViewCell: UITableViewCell {

    @IBOutlet weak var attenBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        attenBtn.layer.cornerRadius = 5
        attenBtn.layer.borderWidth = 0.5
        attenBtn.layer.masksToBounds = true
        attenBtn.layer.borderColor = UIColor.black.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
