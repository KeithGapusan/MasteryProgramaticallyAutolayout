//
//  MenuBar.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 04/12/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class MenuBar: UIView {
  //  let imageList = ["home", "trending","subscription","inbox"]
    
    let menuList : [Menu] = {
        var menu1 =  Menu()
        menu1.title = "Home"
        menu1.imageName = "home"
        
        var menu2 =  Menu()
        menu2.title = "trending"
        menu2.imageName = "trending"
        
        var menu3 =  Menu()
        menu3.title = "subscription"
        menu3.imageName = "subscription"
        
        var menu4 =  Menu()
        menu4.title = "inbox"
        menu4.imageName = "inbox"
        
        return [menu1 , menu2,menu3, menu4]
    }()
    
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
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        let selectedIndexPath = IndexPath(item: 0, section: 0)
            collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: [])
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder has not implemented")
    }
}
extension MenuBar :UICollectionViewDelegate,  UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MenuCell{
            cell.menu = menuList[indexPath.row]
            return cell
        }
        return UICollectionViewCell()
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
