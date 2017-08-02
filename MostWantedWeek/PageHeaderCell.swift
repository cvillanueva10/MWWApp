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
        label.font = UIFont.systemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        addSubview(headerImage)
        addSubview(headerLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: headerImage)
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: headerLabel)
        addConstraintsWithFormat(format: "V:|[v0(\(frame.height * 0.8))]-[v1(\(frame.height*0.2))]", views: headerImage, headerLabel)
    }

}
