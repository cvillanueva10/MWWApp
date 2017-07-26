//
//  EventCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/18/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class EventCell: BaseCell {
    
    let eventName: UILabel = {
        let name = UILabel()
        name.text = "Volleyball Tournament"
        //name.backgroundColor = .red
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    let eventDetails: UITextView = {
        let details = UITextView()
        details.text = "Thursday 7pm - 10pm, Gym"
        details.isEditable = false
        details.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0)
        details.translatesAutoresizingMaskIntoConstraints = false
        return details
    }()
    
    let eventDescription: UITextView = {
        let description = UITextView()
        description.text = "Each sorority participating in MWW will have the chance to win points through our annual volleyball tournament!"
        description.isEditable = false
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.init(white: 0, alpha: 1)
        return line
    }()
    
    override func setupViews() {
        addSubview(eventName)
        addSubview(eventDetails)
        addSubview(eventDescription)
        addSubview(separatorLine)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: eventName)
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: eventDetails)
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: eventDescription)
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: separatorLine)

        addConstraintsWithFormat(format: "V:|-8-[v0(25)]-8-[v1(20)]-8-[v2]-8-[v3(1)]|", views: eventName, eventDetails, eventDescription, separatorLine)
        
    }
}
