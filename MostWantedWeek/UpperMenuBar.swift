//
//  UpperMenuBar.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/28/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class UpperMenuBar: UIView {
    
    let sideMenuBarButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "menu")
        button.setImage(image, for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let writePostButton: UIButton = {
        let wpb = UIButton()
        let image = UIImage(named: "write")
        wpb.setImage(image, for: .normal)
        wpb.layer.masksToBounds = true
        wpb.contentMode = .scaleAspectFill
        wpb.translatesAutoresizingMaskIntoConstraints = false
        return wpb
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(red: 200, green: 31, blue: 32)
        setupView()
    }
    
    func setupView(){
        addSubview(sideMenuBarButton)
        addSubview(writePostButton)
        addSubview(headerLabel)
        
//        headerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        headerLabel.widthAnchor.constraint(equalToConstant: frame.width/2).isActive = true
//        headerLabel.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
    
        addConstraintsWithFormat(format: "V:[v0(30)]-5-|", views: headerLabel)
        addConstraintsWithFormat(format: "H:|-10-[v0(30)]-10-[v1]-10-[v2(30)]-8-|", views: sideMenuBarButton, headerLabel, writePostButton)
        
        addConstraintsWithFormat(format: "V:[v0(30)]-5-|", views: sideMenuBarButton)
//        addConstraintsWithFormat(format: "H:|-10-[v0(36)]", views: sideMenuBarButton)
        
        addConstraintsWithFormat(format: "V:[v0(30)]-5-|", views: writePostButton)
//        addConstraintsWithFormat(format: "H:[v0(34)]-10-|", views: writePostButton)
    }
    

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
