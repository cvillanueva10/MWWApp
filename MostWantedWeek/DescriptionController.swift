//
//  DescriptionController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/19/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

let descriptionUrl = "https://firebasestorage.googleapis.com/v0/b/mostwantedweek-e840a.appspot.com/o/description_info.json?alt=media&token=d16013c2-4953-4cf6-b29c-b1c8789d4c31"

class DescriptionController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let headerId = "headerId"
    let bodyId = "bodyId"
    
    var tab: MenuTab? {
        didSet{
            navigationItem.title = tab?.tabLabelName
        }
    }
    
    var descriptionObjs: [Description]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchDescriptions()
        setupCollectionView()
    }
    
    func fetchDescriptions(){
            let tabName = tab?.tabLabelName
        ApiService.sharedInstance.fetchDescriptions(tabName: tabName!, url: descriptionUrl){ (descriptionObjs) in
            self.descriptionObjs = descriptionObjs
            self.collectionView?.reloadData()
        }
    }
    
    func setupCollectionView(){
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
        
        collectionView?.register(PageHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(DescriptionBody.self, forCellWithReuseIdentifier: bodyId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! PageHeaderCell
        header.descriptionHeader = descriptionObjs?[indexPath.item]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height * 0.5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return descriptionObjs?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyId, for: indexPath) as! DescriptionBody
        cell.descriptionBody = descriptionObjs?[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}


class DescriptionBody: BaseCell {
    
    var descriptionBody: Description? {
        didSet{
            self.descriptionTextView.text = descriptionBody?.descriptionText
        }
    }
    
    let descriptionTextView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = true
        text.font = UIFont.systemFont(ofSize: 14)
        return text
    }()
    
    let thumbnailImageView: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        return image
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(descriptionTextView)
        addSubview(thumbnailImageView)
        
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: descriptionTextView)
        addConstraintsWithFormat(format: "H:|-20-[v0]-20-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "V:|-10-[v0(320)]-10-[v1(\(frame.width / 2))]", views: descriptionTextView, thumbnailImageView)
   
    }
}
