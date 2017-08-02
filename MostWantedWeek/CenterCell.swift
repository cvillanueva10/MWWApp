//
//  CenterCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/18/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

class CenterCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        observeAnnouncements()

        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(AnnouncementCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    var announcementObjs = [Announcement]()
    
//    func updateNumOfLikes(childRef: String, value: Int){
//        
//        Database.database().reference(fromURL: childRef).observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            if let dictionary = snapshot.value as? [String: Any]{
//                let currentLikes = dictionary["numOfLikes"] as! Int
//                let updatedLikes = currentLikes + value
//                
//                Database.database().reference(fromURL: childRef).updateChildValues(["numOfLikes": updatedLikes])
//            }
//            
//        })
// 
//    }
//    
    func observeAnnouncements(){
        
        let ref = Database.database().reference().child("announcements")
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: Any] {
                let announcement = Announcement()
                announcement.setValuesForKeys(dictionary)
                
                if let uid = announcement.fromId{
                    Database.database().reference().child("users").child(uid).observe(.value, with: { (snapshot) in
                        
                        if let dictionary = snapshot.value as? [String: AnyObject] {
                            announcement.name = dictionary["name"] as? String
                            announcement.profileImageUrl = dictionary["profileImageUrl"] as? String
                        }
                        
                        self.announcementObjs.append(announcement)
                        self.announcementObjs.sort(by: { (announcement1, announcement2) -> Bool in
                            return (announcement1.timeStamp?.intValue)! > (announcement2.timeStamp?.intValue)!
                        })
                        
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                        
                    }, withCancel: nil)
                }
            }
        }, withCancel: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return announcementObjs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnnouncementCell
        cell.centerCell = self
        cell.announcement = announcementObjs[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if let announcementText = announcementObjs[indexPath.item].text{
            
            let rect = NSString(string: announcementText).boundingRect(with: CGSize(width: frame.width, height: 2000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            let knownHeight: CGFloat = 16 + 44 + 8 + 16 + 1
            
            return CGSize(width: frame.width, height: rect.height + knownHeight + 60)
        }
        return CGSize(width: frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
