//
//  Score.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/18/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class Score: NSObject {
    
    var logoName: String?
    var teamName: String?
    var scoreNum: String?
    
    init(logoName: String, teamName: String, scoreNum: String){
        self.logoName = logoName
        self.teamName = teamName
        self.scoreNum = scoreNum
    }
}
