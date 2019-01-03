//
//  Setting.swift
//  Youtube
//
//  Created by Keith Randell Gapusan on 02/01/2019.
//  Copyright © 2019 Keith Randell Gapusan. All rights reserved.
//

import Foundation

/*Struct vs Class - Struct cannot derived into @obj class selector*/
class Setting : NSObject {
    var title : SettingName
    var imageName : String?
    
    init(title: SettingName , imageName: String) {
        self.title = title
        self.imageName = imageName
    }
}

enum SettingName:String {
    case Setting = "Setting"
    case Feedback = "Send Feedback"
    case PrivacyPolicy = "Terms & privacy policy"
    case Help = "Help"
    case SwitchAccount = "Switch Account"
    case Cancel = "Cancel"
}
