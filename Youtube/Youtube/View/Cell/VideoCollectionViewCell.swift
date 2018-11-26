//
//  VideoCollectionViewCell.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 25/11/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class VideoCollectionViewCell: UICollectionViewCell {
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupViews()
        }
        let thumbnailImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.blue
            imageView.image = #imageLiteral(resourceName: "blackspace.jpeg")
            // imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        let separator: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.gray
            //view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        let userProfileImageView: UIImageView = {
            let imageView  = UIImageView()
            imageView.backgroundColor = .green
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
            imageView.image = #imageLiteral(resourceName: "profile_image.jpeg")
            return imageView
        }()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            // label.backgroundColor = .gray
            label.text = "December Avenue - Tonight"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        let descTextView: UITextView = {
            let textView = UITextView()
            textView.text = "December Avenue Blank Space- 10,2324323423 views - 2years"
            //  textView.backgroundColor = .yellow
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.contentInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
            textView.textColor = .gray
            return textView
        }()
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        func setupViews(){
            addSubview(thumbnailImageView)
            addSubview(userProfileImageView)
            addSubview(titleLabel)
            addSubview(separator)
            addSubview(descTextView)
            /**
             // Visual format
             addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
             addConstraintsWithFormat(format: "H:|-16-[v0(44)]-8-[v1]-16-|", views: userProfileImageView, titleLabel)
             addConstraintsWithFormat(format: "H:[v0]-8-[v1]-16-|", views: userProfileImageView, descTextView)
             //vertical constraints
             addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView ,separator)
             addConstraintsWithFormat(format: "V:[v0]-8-[v1]-8-[v2]-8-|", views: thumbnailImageView,titleLabel, descTextView)
             
             addConstraintsWithFormat(format: "H:|[v0]-16-|", views: separator)
             */
            addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
            addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: userProfileImageView, titleLabel)
            //vertical constraints
            addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView ,separator)
            
            addConstraintsWithFormat(format: "H:|[v0]|", views: separator)
            //top
            addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
            
            //left
            addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
            
            //right
            addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
            //height
            addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
            
            
            
            //top
            addConstraint(NSLayoutConstraint.init(item: descTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 2))
            //left
            addConstraint(NSLayoutConstraint.init(item: descTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
            //right
            addConstraint(NSLayoutConstraint(item: descTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
            //height
            addConstraint(NSLayoutConstraint(item: descTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        }
    

}
