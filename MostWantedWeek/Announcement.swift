//
//  Announcement.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/9/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class Announcement: NSObject {
    
    var text: String?
    var timeStamp: String?
    
    var profile: Profile?
    
    init(text: String, timeStamp: String, profile: Profile){
        self.text = text
        self.timeStamp = timeStamp
        self.profile = profile
    }
}
