//
//  MenuTab.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/10/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class MenuTab: NSObject {

    var tabLogoName: String
    var tabLabelName: String
    var tabLabelFont = UIFont.systemFont(ofSize: 16)
    
    init(logoName: String, labelName: String) {
        self.tabLogoName = logoName
        self.tabLabelName = labelName
    }
}
