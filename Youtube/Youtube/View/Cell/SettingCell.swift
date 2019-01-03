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
        //   iv.backgroundColor = .red //  for testing porposes
        iv.image = #imageLiteral(resourceName: "subscription")
        return iv
    }()
    let titleLabel : UILabel = {
       let label = UILabel()
       // label.backgroundColor = .blue // for testing porposes
        label.text = "Setting"
        label.numberOfLines = 0
        return label
    }()
    
    let containerView : UIView = {
       let view = UIView()
    //   view.backgroundColor = .gray  //  for testing porposes
        return view
    }()
    
    var setting : Setting? {
        didSet{
            imageView.image = UIImage(named: setting?.imageName ?? "default_image")?.withRenderingMode(.alwaysTemplate)
            imageView.tintColor = .gray
            
            titleLabel.text = setting?.title ?? "Not Available"
            
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
        
            self.backgroundColor = isHighlighted ? UIColor.lightGray : .white
        }
    }
    override func setupView() {
        super.setupView()
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        addConstraintsWithFormat(format: "H:|-16-[v0(25)]-16-[v1]-16-|", views: imageView, titleLabel)
        addConstraintsWithFormat(format: "V:|-16-[v0]-16-|", views: titleLabel)
        addConstraint(NSLayoutConstraint.init(item: imageView , attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }

}
