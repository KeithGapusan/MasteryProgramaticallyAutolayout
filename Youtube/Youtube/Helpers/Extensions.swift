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
