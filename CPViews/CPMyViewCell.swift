//
//  CPMyViewCell.swift
//  CuratedPassport
//
//  Created by SiliconZou on 2017/3/25.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPMyViewCell: UITableViewCell {

    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var myFocusBtn: UIButton!
    @IBOutlet weak var myFavBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
