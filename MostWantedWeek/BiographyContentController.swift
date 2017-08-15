//
//  BiographyContentController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 8/14/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class BiographyContent: NSObject {
    
    let bioImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.borderColor = UIColor.black.cgColor
        iv.layer.borderWidth = 1
        iv.layer.masksToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .gray
        return iv
    }()
    
    let bioContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var dimView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let classLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let majorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let separatorLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.rgb(red: 150, green: 150, blue: 150)
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = UIColor.rgb(red: 100, green: 100, blue: 100)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    var imageWidth: CGFloat?
    var imageHeight: CGFloat?
    var contentHeight: CGFloat?
    var centerX: CGFloat?
    var imageCenterY: CGFloat?
    
    func setupBioContentView(biography: Biography){
        
        if let imageUrl = biography.imageUrl {
            bioImageView.loadImageUsingCacheWithURL(url: imageUrl)
        }
   
        if let year = biography.year {
            yearLabel.text = "Year: " + year
        }
        nameLabel.text = biography.name
        
        majorLabel.text = biography.major
        classLabel.text = biography.pledgeClass
        descriptionTextView.text = biography.descriptionText
        
        bioContentView.addSubview(nameLabel)
        bioContentView.addSubview(yearLabel)
        bioContentView.addSubview(majorLabel)
        bioContentView.addSubview(classLabel)
        bioContentView.addSubview(separatorLine)
        bioContentView.addSubview(descriptionTextView)

        bioContentView.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameLabel)
        bioContentView.addConstraintsWithFormat(format: "H:|-10-[v0(\(bioContentView.frame.width * 0.45))]-[v1]-10-|", views: yearLabel, classLabel)
        bioContentView.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: majorLabel)
        bioContentView.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: descriptionTextView)
        bioContentView.addConstraintsWithFormat(format: "H:|[v0]|", views: separatorLine)

        bioContentView.addConstraintsWithFormat(format: "V:|-(\(bioImageView.frame.height * 0.5 + 5))-[v0(30)]-5-[v1(30)]-0-[v2(30)]-5-[v3(1)]-5-[v4]-5-|", views: nameLabel, yearLabel, majorLabel, separatorLine, descriptionTextView)
        
        classLabel.topAnchor.constraint(equalTo: yearLabel.topAnchor).isActive = true
        classLabel.heightAnchor.constraint(equalTo: yearLabel.heightAnchor).isActive = true
    }
    
    func showBioView(biography: Biography){
        
        if let window = UIApplication.shared.keyWindow{
            let imageWidth = window.frame.width * 0.4
            let imageHeight = imageWidth
            let contentHeight = window.frame.height * 0.5
            let centerX = window.frame.width * 0.5
            let centerY = window.frame.height * 0.5
            
            window.addSubview(dimView)
            window.addSubview(bioContentView)
            window.addSubview(bioImageView)
            
            dimView.frame = window.frame
            dimView.alpha = 0
            
            bioImageView.frame = CGRect(x: centerX - (imageWidth * 0.5), y: window.frame.height, width: imageWidth, height: imageHeight)
            bioContentView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: contentHeight)
            
            bioImageView.layer.cornerRadius = imageHeight * 0.5
            
            setupBioContentView(biography: biography)
     
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.dimView.alpha = 1
                self.bioImageView.frame = CGRect(x: centerX - (imageWidth * 0.5), y: centerY - (imageHeight * 0.5), width: imageWidth, height: imageHeight)
                self.bioContentView.frame = CGRect(x: 0, y: window.frame.height - contentHeight, width: window.frame.width, height: contentHeight)
                
            }, completion: nil)
        }
    }
    
    func handleDismiss(){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            if let window = UIApplication.shared.keyWindow {
                let imageWidth = window.frame.width * 0.4
                let imageHeight = imageWidth
                let contentHeight = window.frame.height * 0.5
                let centerX = window.frame.width * 0.5
                
                self.bioImageView.frame = CGRect(x: centerX - (imageWidth * 0.5), y: window.frame.height, width: imageWidth, height: imageHeight)
                self.bioContentView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: contentHeight)
                self.dimView.alpha = 0
                
            }
            
        }, completion: nil)
    }
    
    override init() {
        super.init()
        
    }
}

