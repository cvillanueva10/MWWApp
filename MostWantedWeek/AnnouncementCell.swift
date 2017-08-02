//
//  AnnouncementCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/5/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

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
    
    var matchingFromId: Bool?
    var fromId: String?
    var childRef: String?

    var isLiked: Bool?
    
    var announcement: Announcement? {
        didSet{
            self.announcementTextView.text = announcement?.text
            self.subtext.text = announcement?.timeFormatted
            self.userName.text = announcement?.name
            self.fromId = announcement?.fromId
            self.childRef = announcement?.childRef
     
            if let profileImageUrl = announcement?.profileImageUrl{
                self.profileImageView.loadImageUsingCacheWithURL(url: profileImageUrl)
            }
        }
    }
    
    let announcementTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let likesEditDeleteBarView: UIView = {
        let view = UIView()
        //view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22;
        imageView.layer.masksToBounds = true;
        return imageView
    }()
    
    let userName: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 16)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let subtext: UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 12)
        text.textColor = UIColor.rgb(red: 170, green: 170, blue: 170)
        text.isEditable = false
        text.textContainerInset = UIEdgeInsetsMake(0, -5, 0, 0)
        text.isScrollEnabled = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    lazy var likesButtonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "like")?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
//        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleLike)))
        return imageView
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deletePostButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var centerCell : CenterCell?
    
//    func handleLike(){
//        
//        if self.isLiked == nil{
//            self.isLiked = false
//        }
//        
//        if self.isLiked == false {
//            self.likesButtonImageView.tintColor = UIColor.rgb(red: 225, green: 32, blue: 31)
//            centerCell?.updateNumOfLikes(childRef: childRef!, value: 1)
//            self.isLiked = true
//        } else if self.isLiked == true {
//            self.likesButtonImageView.tintColor = UIColor.rgb(red: 200, green: 200, blue: 200)
//            centerCell?.updateNumOfLikes(childRef: childRef!, value: -1)
//            self.isLiked = false
//        }
//    }
    
    func setupEditDeleteViews(){
        
        likesEditDeleteBarView.addSubview(deletePostButton)
        
        deletePostButton.rightAnchor.constraint(equalTo: likesEditDeleteBarView.rightAnchor).isActive = true
        deletePostButton.topAnchor.constraint(equalTo: likesEditDeleteBarView.topAnchor).isActive = true
        deletePostButton.heightAnchor.constraint(equalTo: likesEditDeleteBarView.heightAnchor).isActive = true
        deletePostButton.widthAnchor.constraint(equalToConstant: matchingFromId! ? 40 : 1).isActive = true
    }
    
    override func setupViews(){
        addSubview(announcementTextView)
        addSubview(profileImageView)
        addSubview(seperatorView)
        addSubview(userName)
        addSubview(subtext)
        addSubview(likesEditDeleteBarView)
        
//        if self.isLiked == nil {
//            self.likesButtonImageView.tintColor = UIColor.rgb(red: 200, green: 200, blue: 200)
//        }
//        
//        likesEditDeleteBarView.addSubview(likesButtonImageView)
//        likesEditDeleteBarView.addSubview(likesLabel)
        
//        addConstraintsWithFormat(format: "H:|[v0(30)]-5-[v1(100)]", views: likesButtonImageView, likesLabel)
//        addConstraintsWithFormat(format: "V:|[v0]|", views: likesButtonImageView)
//        addConstraintsWithFormat(format: "V:|[v0]|", views: likesLabel)
        
        //Horizontal
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: announcementTextView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: likesEditDeleteBarView)
        
        //Vertical
        addConstraintsWithFormat(format: "V:|-16-[v0(44)]-8-[v1]-12-[v2(30)]-8-[v3(1)]|", views: profileImageView, announcementTextView, likesEditDeleteBarView, seperatorView)
        
        //Height
        //addConstraint(NSLayoutConstraint(item: announcementTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: ))
        
        //Username constraints
        //top
        addConstraint(NSLayoutConstraint(item: userName, attribute: .top, relatedBy: .equal, toItem: profileImageView, attribute: .top, multiplier: 1, constant: 0))
        
        //left
        addConstraint(NSLayoutConstraint(item: userName, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right
        addConstraint(NSLayoutConstraint(item: userName, attribute: .right, relatedBy: .equal, toItem: announcementTextView, attribute: .right, multiplier: 1, constant: 0))
        
        //height
        addConstraint(NSLayoutConstraint(item: userName, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
        
        //Subtext Constraints
        //top
        addConstraint(NSLayoutConstraint(item: subtext, attribute: .top, relatedBy: .equal, toItem: userName, attribute: .bottom, multiplier: 1, constant: 0))
        
        //left
        addConstraint(NSLayoutConstraint(item: subtext, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right
        addConstraint(NSLayoutConstraint(item: subtext, attribute: .right, relatedBy: .equal, toItem: announcementTextView, attribute: .right, multiplier: 1, constant: 0))
        
        //height
        addConstraint(NSLayoutConstraint(item: subtext, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 16))
        
        //Seperator line
        addConstraintsWithFormat(format: "H:|[v0]|", views: seperatorView)
        
        
    }
}


