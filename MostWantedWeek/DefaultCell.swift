//
//  DefaultCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/17/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class DefaultCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let eventCellId = "eventCellId"

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
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
   
    override func setupViews() {
        super.setupViews()
        
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
