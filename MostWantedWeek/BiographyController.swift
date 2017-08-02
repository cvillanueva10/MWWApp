//
//  BiographyController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/26/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class BiographyController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let bodyId = "bodyId"

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }

    func setupCollectionView(){
        
        //collectionView?.contentInset = UIEdgeInsetsMake(0, 10, 10, 10)
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
        
        collectionView?.register(PageHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(BiographyBody.self, forCellWithReuseIdentifier: bodyId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PageHeaderCell
        //header.descriptionHeader = descriptionObjs?[indexPath.item]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height * 0.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyId, for: indexPath) as! BiographyBody
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 3 - 7, height: view.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
}


class BiographyBody: BaseCell {
    
    let thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.masksToBounds = true
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let positionNameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .blue
        addSubview(thumbnailImageView)
        addSubview(nameLabel)
        addSubview(positionNameLabel)
        
        thumbnailImageView.layer.cornerRadius = (frame.width-16)/2
        addConstraintsWithFormat(format: "H:|-8-[v0(\(frame.width-16))]", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-8-[v0(\(frame.width-16))]-8-[v1(\(frame.height/4))]-0-[v2(\(frame.height/8))]", views: thumbnailImageView, nameLabel, positionNameLabel)
        
        
        addConstraintsWithFormat(format: "H:|-8-[v0(\(frame.width-16))]", views: nameLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(\(frame.width-16))]", views: positionNameLabel)
        
        //addConstraint(NSLayoutConstraint(item: lastNameLabel, attribute: .top, relatedBy: .equal, toItem: firstNameLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //addConstraint(NSLayoutConstraint(item: lastNameLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: frame.height/8))
    }
    
}
