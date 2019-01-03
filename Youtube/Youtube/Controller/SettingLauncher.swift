//
//  SettingLauncher.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 25/12/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import Foundation
import UIKit


class SettingLauncher:  NSObject{
    var homeController : HomeController?
    let blackView = UIView()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    let cellId = "cellId"
    
    let settings : [Setting] = {
        var setting = Setting(title: .Setting , imageName: "settings")
        var privacyPolicy = Setting(title: .PrivacyPolicy, imageName: "policy")
        var feedback = Setting(title: .Feedback, imageName: "feedback")
        var help = Setting(title: .Help, imageName: "help")
        var switchAccount = Setting(title: .SwitchAccount , imageName: "account")
        var cancel = Setting(title: .Cancel, imageName: "cancel")
        
        return [
            setting,
            privacyPolicy,
            feedback,
            help,
            switchAccount,
            cancel
        ]
        
    }()
    
    @objc func show(){
        if let window = UIApplication.shared.keyWindow{
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(collectionView)
            blackView.frame = window.frame
            blackView.alpha = 0
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(SettingLauncher.dismiss(setting:))))
            let height :  CGFloat = 350
            let y = ((window.frame.height) - height)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height:height)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame.origin.y = y

            }, completion: nil)
        }
    }
    override init() {
        super.init()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
}
extension SettingLauncher:UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as?  SettingCell{
            cell.setting = settings[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    @objc func dismiss(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame.origin.y = self.collectionView.frame.origin.y +  self.collectionView.frame.size.height

            }
        }) { (completed) in
          //  let setting = self.settings[indexPath.row]
            self.blackView.removeFromSuperview()
            self.collectionView.removeFromSuperview()
            if !setting.isKind(of: UIGestureRecognizer.self) && (setting.title != .Cancel){
                self.homeController?.showController(setting: setting)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.row]
        dismiss(setting: setting)
    }
}
