//
//  AnnouncementCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/5/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews(){
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class AnnouncementCell: BaseCell{
    
    var announcement: Announcement? {
        didSet{
            announcementTextView.text = announcement?.text
            Subtext.text = announcement?.timeStamp
            UserName.text = announcement?.profile?.profileName
            
            if let profileImageName = announcement?.profile?.profileImageName{
            ProfileImageView.image = UIImage(named: profileImageName)
            }
        }
    }
    
    let announcementTextView: UITextView = {
        let textView = UITextView()
        textView.text = "I love Nhung Thi I love Nhung Thi I love Nhung Thi I love Nhung Thi I love Nhung Thi I love Nhung Thi I love Nhung Thi I love Nhung Thi I love Nhung Thi I love Nhung Thi I love Nhung Thi I love Nhung Thi"
        
        return textView
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        return view
    }()
    
    let ProfileImageView: UIImageView = {
        let imageView = UIImageView()
        //imageView.backgroundColor = UIColor.red
        imageView.image = UIImage(named: "ChrisProfilePic")
        imageView.layer.cornerRadius = 22;
        imageView.layer.masksToBounds = true;
        return imageView
    }()
    
    let UserName: UILabel = {
        let name = UILabel()
        //name.backgroundColor = UIColor.gray
        name.text = "Chris Villanueva"
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let Subtext: UITextView = {
        let text = UITextView()
        //text.backgroundColor = UIColor.purple
        text.text = "Posted Tuesday, July 4, 2017 at 10:50pm"
        text.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func setupViews(){
        addSubview(announcementTextView)
        addSubview(ProfileImageView)
        addSubview(seperatorView)
        addSubview(UserName)
        addSubview(Subtext)
        
        //Horizontal
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: announcementTextView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: ProfileImageView)
        
        //Vertical
        addConstraintsWithFormat(format: "V:|-16-[v0(44)]-8-[v1]-16-[v2(1)]|", views: ProfileImageView, announcementTextView, seperatorView)
        
        //Height
        //addConstraint(NSLayoutConstraint(item: announcementTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: ))
        
        //Username constraints
        //top
        addConstraint(NSLayoutConstraint(item: UserName, attribute: .top, relatedBy: .equal, toItem: ProfileImageView, attribute: .top, multiplier: 1, constant: 0))
        
        //left
        addConstraint(NSLayoutConstraint(item: UserName, attribute: .left, relatedBy: .equal, toItem: ProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right
        addConstraint(NSLayoutConstraint(item: UserName, attribute: .right, relatedBy: .equal, toItem: announcementTextView, attribute: .right, multiplier: 1, constant: 0))
        
        //height
        addConstraint(NSLayoutConstraint(item: UserName, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //Subtext Constraints
        //top
        addConstraint(NSLayoutConstraint(item: Subtext, attribute: .top, relatedBy: .equal, toItem: UserName, attribute: .bottom, multiplier: 1, constant: 0))
        
        //left
        addConstraint(NSLayoutConstraint(item: Subtext, attribute: .left, relatedBy: .equal, toItem: ProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right
        addConstraint(NSLayoutConstraint(item: Subtext, attribute: .right, relatedBy: .equal, toItem: announcementTextView, attribute: .right, multiplier: 1, constant: 0))
        
        //height
        addConstraint(NSLayoutConstraint(item: Subtext, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 16))
        
        //Seperator line
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        
    }
    
    
}


