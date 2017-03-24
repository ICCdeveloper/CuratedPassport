//
//  CPMagazineViewCell.swift
//  CuratedPassport
//
//  Created by SiliconZou on 2017/3/18.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPMagazineViewCell: UITableViewCell,ZWAdViewDelagate {
    var magaScrollView:ZWAdView!
    @IBOutlet weak var magaBgView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        magaScrollView = ZWAdView.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        magaBgView.backgroundColor = UIColor.black
        self.magaScrollView.delegate = self
        let imageArr = ["http://img0.c.yinyuetai.com/others/mobile_front_page/161011/0/-M-e5d8927bde6ff61d9d3e909d8b178863_0x0.jpg","http://img2.c.yinyuetai.com/others/mobile_front_page/161009/0/-M-80bfe6af717e267cfc4d846b975a89dd_0x0.jpg","http://img1.c.yinyuetai.com/others/mobile_front_page/161010/0/-M-3913b020fab26fb502b8e2c4f0cb9db7_0x0.jpg","http://img2.c.yinyuetai.com/others/mobile_front_page/161009/0/-M-aab14083c4dcb763af4f50b0acbb420e_0x0.jpg","http://img4.c.yinyuetai.com/others/mobile_front_page/161009/0/-M-34e369b203f31d9c7a95de99079bb905_0x0.jpg"]
        self.magaScrollView.adDataArray = NSMutableArray.init(array: imageArr)
        self.magaScrollView.adAutoplay = false
        self.magaScrollView.adPeriodTime = 2.0
        self.magaScrollView.hidePageControl = true
        self.magaScrollView.placeImageSource = "banner1"
        self.magaScrollView.loadAdDataThenStart()
        self.magaBgView.addSubview(magaScrollView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func adView(_ adView: ZWAdView!, didDeselectAdAtNum num: Int) {
        print(num)
    }
    
}
