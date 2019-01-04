//
//  ViewController.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 18/11/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var videos : [Video]?
    let cellId = "cellId"
    lazy var views : [UIView] =  {
        var listOfView = [UIView]()
        let viewBlue = UIView()
        viewBlue.backgroundColor = .blue
       // let grayView = UIView
        return listOfView
    }()
    let navTittle : [String] = ["Home","Trending","Subscription", "Inbox"]
    let colors: [UIColor] = [UIColor.red, UIColor.blue, UIColor.gray, UIColor.green]

    fileprivate func fetchVideos() {
        APIService.sharedInstance.fetchVideo { (data) in
            self.videos = data
            self.collectionView.reloadData()
        }
    }
    fileprivate func setupNavigationBar(){
        setLabelTitle(indexPath: IndexPath(item: 0, section: 0))
    }
    lazy var titleLabel : UILabel = {
        var label = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
       return label
    }()
    func setLabelTitle(indexPath: IndexPath){
        navigationItem.titleView?.fadeOut()
        self.titleLabel.text = " \(self.navTittle[indexPath.item])"
        navigationItem.titleView?.fadeIn(duration: 1, delay: 0, completion: { (completed) in

        })
        self.navigationItem.titleView = self.titleLabel

        navigationController?.navigationBar.isTranslucent = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupColletionView()
        setupMenuBar()
        setupNavBar()
        
    }
    
    private func setupNavBar(){
        let searchImage = UIImage(named:"search")?.withRenderingMode(.alwaysTemplate)
        let searchButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        searchButton.setImage(searchImage, for: .normal)
        searchButton.imageView?.tintColor = .white
        searchButton.addTarget(self, action: #selector(handleSearch), for: .touchUpInside)
        let searchBarButton = UIBarButtonItem(customView: searchButton)
        let menuBarButton = UIBarButtonItem(image: UIImage(named:"menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItems = [menuBarButton , searchBarButton]
    }
    func scrollManuToItem(indexPath: IndexPath){
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        setLabelTitle(indexPath: indexPath)
    }
    
    
    fileprivate func setupColletionView() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ID")
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        flowLayout?.scrollDirection = .horizontal
        flowLayout?.minimumLineSpacing = 0
        collectionView.isPagingEnabled = true
    }

    
    lazy var settingLauncher : SettingLauncher = {
       var setting = SettingLauncher()
        setting.homeController = self
        return setting
    }()
    
    
    @objc func handleMenu(){
        settingLauncher.show()
    }

    
    @objc func handleSearch(){
        print("search")
    }
    
    
    func showController(setting: Setting){
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        viewController.navigationItem.title = setting.title.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    lazy var menuBar:MenuBar = {
        let mb =  MenuBar()
        mb.homeController = self
        return mb
    }()
   // scrollManuToItem
    private func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31, alpha: 1)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(70)]", views: menuBar)
        print("menu bar view \(menuBar.frame.size)")
        let guide = view.safeAreaLayoutGuide
        menuBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.item {
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ID", for: indexPath)
            cell.backgroundColor = .blue
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            cell.backgroundColor = colors[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width, height: self.view.frame.size.height - 20)
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let targetOffset = targetContentOffset.pointee.x / view.frame.width
        let indexPath =  IndexPath(item: Int(targetOffset), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        setLabelTitle(indexPath:indexPath)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / 4
        menuBar.horizontalBarViewLeftConstraints?.constant = index
    }
    
}


