//
//  MenuCell.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 18/12/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import UIKit


class MenuCell : BaseCell{
    
    var menu: Menu?{
        didSet{
            if let name = menu?.imageName {
                self.imageView.image = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.image = iv.image?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    override var isSelected: Bool{
        didSet{
            self.imageView.tintColor = self.isSelected ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
                self.imageView.tintColor = self.isHighlighted ? UIColor.white : UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        }
    }
    override func setupView() {
        addSubview(imageView)
        addConstraintsWithFormat(format: "H:[v0(25)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(25)]", views: imageView)
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
