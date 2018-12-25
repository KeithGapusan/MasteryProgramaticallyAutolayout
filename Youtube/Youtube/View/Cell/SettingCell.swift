//
//  SettingCell.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 25/12/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import Foundation
import UIKit


class SettingCell: BaseCell {
    let imageView  : UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .red
        iv.image = #imageLiteral(resourceName: "subscription")
        return iv
    }()
    let titleLabel : UILabel = {
       let label = UILabel()
        label.backgroundColor = .blue
        label.text = "Setting"
        label.numberOfLines = 0
        return label
    }()
    
    let containerView : UIView = {
       let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    override func setupView() {
        super.setupView()
       // self.backgroundColor = .blue
       // self.addSubview(containerView)
        self.addSubview(imageView)
        self.addSubview(titleLabel)
//        addConstraintsWithFormat(format: "H:|[v0]|", views: containerView)
//        
//        print(containerView.frame.size.width)
//        addConstraintsWithFormat(format: "V:|[v0]|", views: containerView)
        
        
        addConstraintsWithFormat(format: "H:|-16-[v0(25)]-16-[v1]-16-|", views: imageView, titleLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: titleLabel)
        addConstraint(NSLayoutConstraint.init(item: imageView , attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }

}
