//
//  MenuBar.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 04/12/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    let imageList = [#imageLiteral(resourceName: "home"), #imageLiteral(resourceName: "trending"),#imageLiteral(resourceName: "subscription"),#imageLiteral(resourceName: "inbox")]
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    let cellId  = "cellId"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
     //   print("collection view \(collectionView.frame.size)")
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
       // self.collectionView.estimatedItemSize = CGSize(width: 100, height: 100)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not implemented")
    }
}
extension MenuBar :UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        
        cell.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31, alpha: 1)
        cell.imageView.image = imageList[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath:  IndexPath) -> CGSize {

        return CGSize(width: frame.width / 4  , height:frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

}
