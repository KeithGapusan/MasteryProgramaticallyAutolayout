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
    
    
    func fetchVideo(){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                //print(json)
                self.videos = [Video]()
                for dict in json as! [[String:Any]]{
                    let video = Video()
                    video.title = dict["title"] as? String
                    video.thumbnailImageName = dict["thumbnail_image_name"] as? String
                    let channelDictionary = dict["channel"] as! [String:Any]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    self.videos?.append(video)
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                    
                }
            } catch let jsonError{
                print(jsonError)
            }
            
            }.resume()
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchVideo()
        navigationItem.title = "Home"
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        
        navigationItem.titleView = titleLabel
        navigationController?.navigationBar.isTranslucent = false
        
        collectionView.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
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
    
    lazy var settingLauncher : SettingLauncher = {
       var setting = SettingLauncher()
        setting.homeController = self
        
        return setting
    }()
    
    
    @objc func handleMenu(){
      //  settingLauncher.homeController = self
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
    
    let menuBar:MenuBar = {
        let mb =  MenuBar()
        return mb
    }()
    private func setupMenuBar(){
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31, alpha: 1)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        print("menu bar view \(menuBar.frame.size)")
        let guide = view.safeAreaLayoutGuide
        menuBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = videos?.count{
            return count
        }
        return 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCollectionViewCell
        //  cell.backgroundColor = .red
        
        cell.video = videos?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width -  16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}




