//
//  DescriptionController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/19/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

let databaseUrl = "https://mostwantedweek-e840a.firebaseio.com/"

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
        
        fetchInfo()
        
        setupCollectionView()
    }
    
    func fetchInfo(){
        let tabName = tab?.tabLabelName
        let url = URL(string: "file:///Users/christophervillanueva/Desktop/description_info.json")
                URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    DispatchQueue.main.async(execute: { 
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                            self.descriptionObjs = [Description]()
//
                            
                            for dictionary in json as! [[String: AnyObject]] {
                                if let name = tabName{
                                    let subdictionary = dictionary[name]
                                    let descriptionobj = Description()
                                    descriptionobj.descriptionText = subdictionary?["description"] as? String
                                    descriptionobj.headerImage = subdictionary?["headerimage"] as? String
                                    descriptionobj.headerLabel = subdictionary?["headerlabel"] as? String
                                    
                                    self.descriptionObjs?.append(descriptionobj)
                                }
                            }
                            
                            self.collectionView?.reloadData()
                            
                        } catch let jsonError{
                            print(jsonError)
                        }
                    })
        }.resume()
    }
    
    func setupCollectionView(){
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = .white
        
        collectionView?.register(DescriptionHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView?.register(DescriptionBody.self, forCellWithReuseIdentifier: bodyId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DescriptionHeader
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

class DescriptionHeader: BaseCell{

    var descriptionHeader: Description?{
        didSet{
            if let imageName = descriptionHeader?.headerImage {
                 headerImage.image = UIImage(named: imageName)
            }
            headerLabel.text = descriptionHeader?.headerLabel
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

class DescriptionBody: BaseCell {
    
    var descriptionBody: Description? {
        didSet{
            descriptionTextView.text = descriptionBody?.descriptionText
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
        
        backgroundColor = .blue
    }
}
