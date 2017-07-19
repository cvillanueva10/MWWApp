//
//  ScoreCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/18/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class ScoreCell: BaseCell {
    
    let teamLogo: UIImageView = {
        let logo = UIImageView()
        logo.backgroundColor = .red
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.layer.masksToBounds = true
        return logo
    }()
    
    let teamName: UILabel = {
        let name = UILabel()
        //name.backgroundColor = .blue
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let scoreNumber: UILabel = {
        let num = UILabel()
       // num.backgroundColor = .purple
        num.translatesAutoresizingMaskIntoConstraints = false
        return num
    }()
    
    var score: Score? {
        didSet{
            teamName.text = score?.teamName
            scoreNumber.text = score?.scoreNum
            if let logoName = score?.logoName{
                teamLogo.image = UIImage(named: logoName)
            }
        }
    }
   
    override func setupViews(){
        addSubview(teamLogo)
        addSubview(teamName)
        addSubview(scoreNumber)
        
        addConstraintsWithFormat(format: "H:|-10-[v0(100)]-10-[v1]-10-|", views: teamLogo, teamName)
        addConstraintsWithFormat(format: "V:|-10-[v0(75)]", views: teamLogo)
        
        addConstraintsWithFormat(format: "V:|-10-[v0(30)]", views: teamName)

        addConstraint(NSLayoutConstraint(item: scoreNumber, attribute: .bottom, relatedBy: .equal, toItem: teamLogo, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: scoreNumber, attribute: .left, relatedBy: .equal, toItem: teamLogo, attribute: .right, multiplier: 1, constant: 10))
        addConstraint(NSLayoutConstraint(item: scoreNumber, attribute: .right, relatedBy: .equal, toItem: teamName, attribute: .right, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: scoreNumber, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}
