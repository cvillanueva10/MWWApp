//
//  DeleteAnnouncementController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 9/4/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

class DeleteAnnouncementController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    let centerCell = CenterCell()
    var announcementObjs = [Announcement]()
    
    func observeAnnouncements() {
        
        let ref = Database.database().reference().child("announcements")
        ref.observe(.childAdded, with: { (snapshot) in
  
            if let dictionary = snapshot.value as? [String: Any] {
                let announcement = Announcement()
                announcement.header = dictionary["header"] as? String
                announcement.name = dictionary["name"] as? String
                announcement.childRef = dictionary["childRef"] as? String
                self.announcementObjs.append(announcement)
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
            
        }, withCancel: nil)
    }
    
    func deleteAnnouncement(indexPath: IndexPath, index: Int, childRef: String) {
        
        Database.database().reference(fromURL: childRef).removeValue { (error, ref) in
            if error != nil {
                print(error!)
            }
            print("deleted")
            self.centerCell.observeDeleted(index: index)
     
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.rgb(red: 200, green: 200, blue: 200)
        collectionView?.register(ViewAnnouncementCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.allowsMultipleSelection = true
        observeAnnouncements()
    }
    
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return announcementObjs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ViewAnnouncementCell
        cell.announcement = announcementObjs[indexPath.item]
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height * 0.12)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let childRef = announcementObjs[indexPath.item].childRef {
            deleteAnnouncement(indexPath: indexPath, index: indexPath.item, childRef: childRef)
        }
        
    }
}

class ViewAnnouncementCell: BaseCell {
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    var announcement: Announcement? {
        didSet {
            headerLabel.text = announcement?.header
        }
    }
    
    override func setupViews() {
        super.setupViews()
     
        backgroundColor = .white
        addSubview(headerLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: headerLabel)
        addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: headerLabel)
    }
}
