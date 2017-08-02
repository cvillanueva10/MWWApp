//
//  EventCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/18/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class EventCell: BaseCell {
    
    var event: Event? {
        didSet{
            self.eventDate.text = event?.date
            self.eventName.text = event?.name
            self.eventLocation.text = event?.location
            self.eventTime.text = event?.time
            self.eventDescription.text = event?.eventDescription
        }
    }
    
    let eventDate: UILabel = {
        let date = UILabel()
        date.font = UIFont.boldSystemFont(ofSize: 26)
        date.layer.borderColor = UIColor.black.cgColor
        date.layer.borderWidth = 0.5
        date.textAlignment = .center
        date.backgroundColor = UIColor.rgb(red: 210, green: 210, blue: 210)
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    let eventName: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 24)
        name.textAlignment = .center
        name.layer.borderColor = UIColor.black.cgColor
        name.layer.borderWidth = 0.5
        //name.backgroundColor = .orange
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let eventTime: UILabel = {
        let time = UILabel()
        time.textAlignment = .center
        time.layer.borderColor = UIColor.black.cgColor
        time.layer.borderWidth = 0.5
        time.font = UIFont.boldSystemFont(ofSize: 16)
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    let eventLocation: UILabel = {
        let location = UILabel()
        location.textAlignment = .center
        location.layer.borderColor = UIColor.black.cgColor
        location.layer.borderWidth = 0.5
        location.font = UIFont.boldSystemFont(ofSize: 16)
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()
    
    let eventDescription: UITextView = {
        let description = UITextView()
        description.font = UIFont.systemFont(ofSize: 14)
        description.layer.borderColor = UIColor.black.cgColor
        description.layer.borderWidth = 0.5
        description.isEditable = false
        description.isScrollEnabled = false
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    override func setupViews() {
        addSubview(eventDate)
        addSubview(eventName)
        addSubview(eventTime)
        addSubview(eventLocation)
        addSubview(eventDescription)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: eventDate)
        addConstraintsWithFormat(format: "H:|[v0]|", views: eventName)
        addConstraintsWithFormat(format: "H:[v0(\(frame.width/2))]|", views: eventTime)
        addConstraintsWithFormat(format: "H:|[v0]|", views: eventDescription)

        addConstraintsWithFormat(format: "V:|[v0(40)]-0-[v1(40)]-0-[v2(30)]-0-[v3]|", views: eventDate, eventName, eventTime, eventDescription)
        
        addConstraint(NSLayoutConstraint(item: eventLocation, attribute: .left, relatedBy: .equal, toItem: eventName, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: eventLocation, attribute: .top, relatedBy: .equal, toItem: eventTime, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: eventLocation, attribute: .width, relatedBy: .equal, toItem: eventTime, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: eventLocation, attribute: .height, relatedBy: .equal, toItem: eventTime, attribute: .height, multiplier: 1, constant: 0))
        
    }
}
