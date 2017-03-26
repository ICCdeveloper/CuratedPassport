//
//  CPHomeExtension.swift
//  CuratedPassport
//
//  Created by SiliconZou on 2017/3/26.
//  Copyright © 2017年 ICCorg. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
//tableview代理方法的扩展
extension CPHomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    //MARK:  tableview代理方法
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView.isEqual(homeTableView) {
            return 4
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.isEqual(homeTableView) {
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
        } else {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CPDetailViewCell", for: indexPath) as! CPDetailViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CPVisaViewCell", for: indexPath) as! CPVisaViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.isEqual(homeTableView) {
            
            if indexPath.section == 1 {
                
                let cpInfo = CPInfoViewController()
                //转场动画
                let transition = CATransition()
                
                //动画时间
                transition.duration = 0.8
                
                //动画方向（在某些类型的动画里会失效）
                transition.subtype = kCATransitionFromRight
                
                //动画类型
                transition.type = kCATransitionReveal
                
                transition.type = "rippleEffect"
                /*
                 fade moveIn push reveal	和系统预设的四种一样
                 pageCurl pageUnCurl		翻页
                 rippleEffect			滴水效果
                 suckEffect			收缩效果，如一块布被抽走
                 cube alignedCube		立方体效果
                 flip alignedFlip oglFlip		翻转效果
                 rotate				旋转
                 cameraIris cameraIrisHollowOpen cameraIrisHollowClose 相机
                 */
                
                self.navigationController?.view.layer.add(transition, forKey: nil)
                
                self.navigationController?.pushViewController(cpInfo, animated: false)
                
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView.isEqual(homeTableView) {
            
            if indexPath.section == 0 {
                return 240
            } else if indexPath.section == 1 {
                return 100
            } else if indexPath.section == 2 {
                return 40
            } else {
                return 100
            }
        } else {
            if indexPath.section == 0 {
                return 220
            } else {
                return 300
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView.isEqual(homeTableView) {
            if section == 3 {
                return 0
            } else if section == 1 {
                return 0
            }
            return 30
        } else {
            return 0
        }
        
        
    }
}

extension CPHomeViewController:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        let coordinate = currentLocation?.coordinate
        let longitude = coordinate?.longitude
        let latitute = coordinate?.latitude
        self.locateManager.stopUpdatingLocation()
        
        let geocoder = CLGeocoder.init()
        let location = CLLocation.init(latitude: latitute!, longitude: longitude!)
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            let place = placemarks?.first
            print("详细信息:",place?.name! as Any)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("进入了区域" + region.identifier)
        let acon = UIAlertController.init(title: "地理提示", message: "您已进入该区域", preferredStyle: .alert)
        let ac1 = UIAlertAction.init(title: "确定", style: .default, handler: nil)
        acon.addAction(ac1)
        self.present(acon, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("出了区域" + region.identifier)
        let acon = UIAlertController.init(title: "地理提示", message: "您已出了该区域", preferredStyle: .alert)
        let ac1 = UIAlertAction.init(title: "确定", style: .default, handler: nil)
        acon.addAction(ac1)
        self.present(acon, animated: true, completion: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        if region.identifier == "id" {
            switch state {
            case .inside:
                print("在内部")
                let acon = UIAlertController.init(title: "地理提示", message: "您已在内部", preferredStyle: .alert)
                let ac1 = UIAlertAction.init(title: "确定", style: .default, handler: nil)
                acon.addAction(ac1)
                self.present(acon, animated: true, completion: nil)
            case.outside:
                print("在外部")
                let acon = UIAlertController.init(title: "地理提示", message: "您已在外部", preferredStyle: .alert)
                let ac1 = UIAlertAction.init(title: "确定", style: .default, handler: nil)
                acon.addAction(ac1)
                self.present(acon, animated: true, completion: nil)
            default:
                print("未知")
                let acon = UIAlertController.init(title: "地理提示", message: "未知", preferredStyle: .alert)
                let ac1 = UIAlertAction.init(title: "确定", style: .default, handler: nil)
                acon.addAction(ac1)
                self.present(acon, animated: true, completion: nil)
            }
        }
    }
}
