//
//  APIService.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 04/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation


class APIService:  NSObject {
    static let sharedInstance = APIService()
    
    func fetchVideo(completion: @escaping ([Video]) -> ()){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil{
                return
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                //print(json)
                var videos = [Video]()
                for dict in json as! [[String:Any]]{
                    let video = Video()
                    video.title = dict["title"] as? String
                    video.thumbnailImageName = dict["thumbnail_image_name"] as? String
                    let channelDictionary = dict["channel"] as! [String:Any]
                    let channel = Channel()
                    channel.name = channelDictionary["name"] as? String
                    
                    channel.profileImageName = channelDictionary["profile_image_name"] as? String
                    
                    video.channel = channel
                    videos.append(video)
                }
                DispatchQueue.main.async {
                    completion(videos)
                }
            } catch let jsonError{
                print(jsonError)
            }
            
        }.resume()
        
        
        
    }
    
    
}
