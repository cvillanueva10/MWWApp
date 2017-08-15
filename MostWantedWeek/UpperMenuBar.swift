//
//  UpperMenuBar.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/28/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var headerProfileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 15
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowProfile)))
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        backgroundColor = UIColor.rgb(red: 200, green: 31, blue: 32)
        setupView()
    }
    
    func setupView(){
        addSubview(sideMenuBarButton)
        addSubview(writePostButton)
        //      addSubview(headerLabel)
        addSubview(headerProfileImage)
        
        setHeaderProfileImage()
        
        //        addConstraintsWithFormat(format: "V:[v0(30)]-5-|", views: headerLabel)
        //        addConstraintsWithFormat(format: "H:|-10-[v0(30)]-10-[v1]-10-[v2(30)]-8-|", views: sideMenuBarButton, headerLabel, writePostButton)
        
        addConstraintsWithFormat(format: "V:[v0(30)]-5-|", views: sideMenuBarButton)
        addConstraintsWithFormat(format: "H:|-10-[v0(30)]", views: sideMenuBarButton)
        
        addConstraintsWithFormat(format: "V:[v0(30)]-5-|", views: writePostButton)
        addConstraintsWithFormat(format: "H:[v0(30)]-10-|", views: writePostButton)
        
        headerProfileImage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerProfileImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        headerProfileImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        headerProfileImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setHeaderProfileImage(){
        
        if Auth.auth().currentUser?.uid == nil {
            
            self.headerProfileImage.image = UIImage(named: "")
            return
        } else {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    
                    if let profileImageUrl = dictionary["profileImageUrl"] as? String{
                        self.headerProfileImage.loadImageUsingCacheWithURL(url: profileImageUrl)
                    }
                }
            }, withCancel: nil)
        }
    }
    
    var homeController: HomeController?
    
    func handleShowProfile(){
        homeController?.showProfilePage()
    }

  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
