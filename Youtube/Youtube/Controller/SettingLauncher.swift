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
    
    let blackView = UIView()
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    let cellId = "cellId"
    
    let settings : [Setting] = {
        var setting = Setting.init(title: "Setting", imageName: "settings")
        var privacyPolicy = Setting.init(title: "Terms & privacy policy ", imageName: "policy")
        var feedback = Setting.init(title: "Send Feedback", imageName: "feedback")
        var help = Setting.init(title: "Help", imageName: "help")
        var switchAccount = Setting.init(title: "Switch Account ", imageName: "account")
        var cancel = Setting.init(title: "Cancel", imageName: "cancel")
        
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
        print("menu")
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(collectionView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss)))
            let height :  CGFloat = 350
            let y = ((window.frame.height) - height)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height:height)
            print("width\(collectionView.frame.width)")
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame.origin.y = y

            }, completion: nil)
        }
    }
    @objc func dismiss(){
       // print("handle dismiss")
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            self.collectionView.frame.origin.y = self.collectionView.frame.origin.y +  self.collectionView.frame.size.height

        }) { (completed) in
            if completed {
                self.blackView.removeFromSuperview()
                self.collectionView.removeFromSuperview()
            }
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
}
