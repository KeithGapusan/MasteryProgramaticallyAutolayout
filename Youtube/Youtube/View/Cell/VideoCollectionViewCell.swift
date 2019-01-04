//
//  VideoCollectionViewCell.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 25/11/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import UIKit


class VideoCollectionViewCell: UICollectionViewCell {
    
    var video : Video?{
        didSet{
            titleLabel.text = video?.title
            if let channelName = video?.channel?.name ,  let numberOfViews =  video?.numberOfViews{
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let subtitleText = "\(channelName) - \(numberFormatter.string(from: (numberOfViews as NSNumber)) ?? "") "
                descTextView.text = subtitleText
                
            }
            
            if let videoTitle = video?.title{
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: videoTitle).boundingRect(with: size, options: options, attributes:  [.font: UIFont.systemFont(ofSize: 14.0)], context: nil)
                // videoTitle.size(withAttributes: [.font: UIFont.systemFont(ofSize: 17.0)]) ?? .zero
                if estimatedRect.size.height > 20 {
                    //   titleLabelHeight
                    titleLabelHeightConstraint?.constant = 44
                }else{
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            setupProfileImage()
            setUpThumbnailImage()
        }
    }
    var titleLabelHeightConstraint: NSLayoutConstraint?
    
    func setupProfileImage(){
        if let profileImageUrl = video?.channel?.profileImageName {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)

        }
        
    }
    
    func setUpThumbnailImage(){
        if let thumbnailImageUrl = video?.thumbnailImageName{
            thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
       // imageView.backgroundColor = UIColor.blue
        imageView.image = #imageLiteral(resourceName: "blackspace.jpeg")
        imageView.contentMode = .scaleAspectFit
 
        // imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        //view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let userProfileImageView: CustomImageView = {
        let imageView  = CustomImageView()
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.image = #imageLiteral(resourceName: "profile_image.jpeg")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        // label.backgroundColor = .gray
        label.text = "December Avenue - Tonight"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let descTextView: UITextView = {
        let textView = UITextView()
        textView.text = "December Avenue Blank Space- 10,2324323423 views - 2years"
        textView.backgroundColor = .yellow
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
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-60-[v2(1)]|", views: thumbnailImageView, userProfileImageView ,separator)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separator)
        //top
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left
        addConstraint(NSLayoutConstraint.init(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        addConstraint(titleLabelHeightConstraint!)
        
        
        //top
        addConstraint(NSLayoutConstraint.init(item: descTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left
        addConstraint(NSLayoutConstraint.init(item: descTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right
        addConstraint(NSLayoutConstraint(item: descTextView, attribute: .right, relatedBy: .equal, toItem: titleLabel, attribute: .right, multiplier: 1, constant: 0))
        //height
        let descTextViewHeightConstraints = NSLayoutConstraint(item: descTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 40)
        //height constraint
        //            titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 44)
        addConstraint(descTextViewHeightConstraints)
        //height constraint
        //            addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
        
    }
    
    
}
