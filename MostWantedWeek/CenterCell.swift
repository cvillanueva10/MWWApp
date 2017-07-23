//
//  CenterCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/18/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

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
    
//    var announcementObjs: [Announcement]?
//    var profileObjs: [Profile]?
    
    var announcementObjs: [Announcement] = {
        var chrisProfile = Profile(profileImageName: "ChrisProfilePic", profileName: "Chris Villanueva")
        var nhungProfile = Profile(profileImageName: "NhungProfilePic", profileName: "Nhung Nguyen")
        var leoProfile = Profile(profileImageName: "LeoProfilePic",profileName: "Leo" )
        var nhungAnnouncement = Announcement(text: "Test", timeStamp: "Sunday, July 9, 2017 at 3:59pm", profile: nhungProfile)
        var leoAnnouncement = Announcement(text: "Test #3", timeStamp: "Sunday, July 9, 2017 at 4:00pm", profile: leoProfile)
        var chrisAnnouncement = Announcement(text: "Test #2",timeStamp: "Sunday, July 9, 2017 at 4:01pm", profile: chrisProfile )
        var chrisTestAnnouncement = Announcement(text: "Test",timeStamp: "Sunday, July 9, 2017 at 3:40pm", profile: chrisProfile )
        
        return [chrisTestAnnouncement, nhungAnnouncement, leoAnnouncement, chrisAnnouncement]
    }()
  
//    func fetchAnnouncements(){
//        
//        let url = URL(string: "file:///Users/christophervillanueva/Desktop/test_announcements.json")
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            
//            if error != nil {
//                print(error!)
//                return
//            }
//            
//            
//            DispatchQueue.main.async(execute: {
//                
//            })
//            
//            do{
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                
//                self.announcementObjs = [Announcement]()
//                self.profileObjs = [Profile]()
//                
//                for dictionary in json as! [[String: AnyObject]] {
////                
//                   let profile = Profile()
//                   let announcementObj = Announcement()
//                   let pDictionary = dictionary["profile"]
//                    
//                    profile.profileName = pDictionary?["profile_name"] as? String
////                    profile.profileImageName = dictionary["profile_image_name"] as? String
//                    
//                    announcementObj.profile = profile
//                    announcementObj.text = dictionary["text"] as? String
//                    announcementObj.timeStamp = dictionary["timestamp"] as? String
//                    
//                    self.profileObjs?.append(profile)
//                    self.announcementObjs?.append(announcementObj)
//
//                    
//                }
//                
//                
//                self.collectionView.reloadData()
//          
//            } catch let jsonError{
//                print(jsonError)
//            }
//            
//        }.resume()
//    }
    
    override func setupViews() {
        super.setupViews()
        
//        fetchAnnouncements()
        
        backgroundColor = .brown
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.register(AnnouncementCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return announcementObjs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnnouncementCell
        cell.announcement = announcementObjs[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
