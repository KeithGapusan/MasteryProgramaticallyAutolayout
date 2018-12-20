//
//  MenuCell.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 18/12/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import UIKit


class MenuCell : BaseCell{
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    override func setupView() {
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(25)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(25)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
