//
//  ViewController.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 18/11/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
//    var videos :[Video] = {
//        var channel = Channel()
//        channel.name = "KanyeIsTheBestChannel"
//        channel.profileImageName = "profile_image"
//
//        var blankSpaceVideo = Video()
//        blankSpaceVideo.title = "Taylor Swift - BlankSpace"
//        blankSpaceVideo.thumbnailImageName = "blackspace"
//        blankSpaceVideo.channel = channel
//        blankSpaceVideo.numberOfViews = 12312332
//
//        var channel2 = Channel()
//        channel2.name = "Taylor Swift2"
//        channel2.profileImageName = "profile_image"
//
//
//        var badBloodVideo = Video()
//        badBloodVideo.thumbnailImageName = "badblood"
//        badBloodVideo.title = "Taylor Swift - Bad Blood featuring Kendrick Lamar"
//        badBloodVideo.channel = channel2
//        badBloodVideo.numberOfViews = 12312312443
//        return [blankSpaceVideo, badBloodVideo]
//    }()
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
                    print(dict["title"])
                    let video = Video()
                    video.title = dict["title"] as? String
                    self.videos?.append(video)
                }
                DispatchQueue.main.async {
                     self.collectionView?.reloadData()
                    print(self.videos?.count)
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
        let searchBarButton = UIBarButtonItem(image: UIImage(named:"search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        let menuBarButton = UIBarButtonItem(image: UIImage(named:"menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMenu))
        navigationItem.rightBarButtonItems = [menuBarButton , searchBarButton]
    }
    
    
    @objc func handleMenu(){
        print("menu")
    }
    @objc func handleSearch(){
       print("search")
    }
    
    let menuBar:MenuBar = {
        let mb =  MenuBar()
        return mb
    }()
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
        print("menu bar view \(menuBar.frame.size)")
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




