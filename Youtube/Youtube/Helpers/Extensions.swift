//
//  Extensions.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 25/11/2018.
//  Copyright © 2018 Keith Randell Gapusan. All rights reserved.
//

import Foundation
import UIKit


extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
extension UIView{
    func addConstraintsWithFormat(format: String, views:UIView...){
        var viewsDictionary = [String:UIView]()
        for (index, view) in views.enumerated(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 3.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: completion)

    }
    

}
let imageCache = NSCache<AnyObject, AnyObject>()



class CustomImageView: UIImageView{
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString:String){
        
        imageUrlString = urlString
        
        let url = URL(string: urlString)
        image = nil
        if let cache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cache
            return
        }
            URLSession.shared.dataTask(with: url!) {
                (data, response, error) in
                if error != nil{
                    print(error ?? "")
                    return
                }
                DispatchQueue.main.async {
                    let cache = UIImage(data: data!)
                    if self.imageUrlString == urlString{
                        self.image = cache
                    }
                    imageCache.setObject(cache!, forKey: urlString as AnyObject)
                }
            }.resume()
        }
}
//extension UINavigationController {
//
//    override open func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.navigationBar.barStyle = .lightContent
//    }
//    override open var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//    
//}
