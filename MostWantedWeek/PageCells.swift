//
//  PageHeaderCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/26/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class PageHeaderCell: BaseCell {

    var descriptionHeader: Description?{
        didSet{
            if let imageName = descriptionHeader?.headerImage {
                self.headerImage.image = UIImage(named: imageName)
            }
            self.headerLabel.text = descriptionHeader?.headerLabel
        }
    }
    
    let headerImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .green
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()
    
    let headerLabel : UILabel = {
        let label = UILabel()
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.backgroundColor = UIColor.rgb(red: 200, green: 32, blue: 31)
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(headerImage)
        addSubview(headerLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: headerImage)
        addConstraintsWithFormat(format: "H:|[v0]|", views: headerLabel)
        addConstraintsWithFormat(format: "V:|[v0(\(frame.height * 0.8))]-0-[v1(\(frame.height*0.2))]", views: headerImage, headerLabel)
    }
}

class PageBodyCell: BaseCell {
    
    var descriptionBody: Description? {
        didSet{
            self.descriptionTextView.text = descriptionBody?.descriptionText
        }
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let breakdownLabel: UILabel = {
        let label = UILabel()
        label.text = "Breakdown"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = true
        text.font = UIFont.systemFont(ofSize: 16)
        text.textColor = UIColor.rgb(red: 120, green: 120, blue: 120)
        text.isEditable = false
        return text
    }()
    
    let thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        return image
    }()
    
    let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.rgb(red: 70, green: 70, blue: 70)
        return line
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .white
        
        addSubview(descriptionTextView)
        addSubview(thumbnailImageView)
        addSubview(descriptionLabel)
        addSubview(separatorLine)
        addSubview(breakdownLabel)
        
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: descriptionTextView)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-15-[v0]|", views: descriptionLabel)
        addConstraintsWithFormat(format: "H:|-15-[v0]|", views: breakdownLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: separatorLine)
        addConstraintsWithFormat(format: "V:|-10-[v0(30)]-0-[v1(500)]-0-[v2(1)]-10-[v3(30)]-10-[v4(\(frame.width / 2))]", views: descriptionLabel, descriptionTextView, separatorLine,breakdownLabel, thumbnailImageView)
    }
}

