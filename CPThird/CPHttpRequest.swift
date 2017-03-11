//
//  CPHttpRequest.swift
//  CuratedPassport
//
//  Created by ICCorg on 2017/3/11.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import UIKit

class CPHttpRequest: NSObject {
    
    class func POST(success suc:@escaping (_ data:Data) -> Void ,fail fa:@escaping (_ reason: String) -> Void, urlString: String) {
        
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer.setValue("8460bb34be3922cb9ebaa1f3d6283168", forHTTPHeaderField: "Device-Id")
        manager.requestSerializer.setValue("10101042", forHTTPHeaderField: "App-Id")
        manager.requestSerializer.setValue("aVBob25lIE9TXzkuMy41Xzc1MCoxMzM0XzEwMDAwMTAwMF9pUGhvbmUgNg", forHTTPHeaderField: "Device-V")
        manager.post(urlString, parameters: nil, progress: nil, success: { (task, data) in
            suc(data as! Data)
        }) { (task, error) in
            fa(error.localizedDescription)
        }
        
    }
    
    class func GET(success suc: @escaping (_ data:Data) -> Void ,fail fa: @escaping (_ reason: String) -> Void, urlString:String) {
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.get(urlString, parameters: nil, progress: nil, success: { (task, data) in
            suc(data as! Data)
        }) { (task, error) in
            fa(error.localizedDescription)
        }
    }

}
