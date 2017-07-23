//
//  SettingCells.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/10/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? UIColor.lightGray : UIColor.white
            tabLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            tabIcon.tintColor = isHighlighted ? UIColor.white : UIColor.lightGray
        }
    }
    var menuTab: MenuTab? {
        didSet{
            tabLabel.text = menuTab?.tabLabelName
            tabLabel.font = menuTab?.tabLabelFont
            
           if let logoImageName = menuTab?.tabLogoName{
                tabIcon.image = UIImage(named: logoImageName)?.withRenderingMode(.alwaysTemplate)
                tabIcon.tintColor = UIColor.lightGray
            }
        }
    }
    
    let tabLabel: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        return label
    }()
    
    let tabIcon: UIImageView = {
        let icon = UIImageView() 
        icon.image = UIImage(named: "LeoProfilePic")
        icon.contentMode = .scaleAspectFill
        icon.layer.masksToBounds = true;
        return icon
    }()
    
    let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        return line
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(tabLabel)
        addSubview(tabIcon)
        addSubview(separatorLine)
        
        addConstraintsWithFormat(format: "H:|-8-[v0(35)]-8-[v1]|", views: tabIcon, tabLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorLine )
        
        addConstraintsWithFormat(format: "V:[v0(35)]-8-[v1(1)]", views: tabIcon, separatorLine)
        addConstraintsWithFormat(format: "V:|-8-[v0]-8-|", views: tabLabel)
        
        addConstraint(NSLayoutConstraint(item: tabIcon, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
       
        }
}
