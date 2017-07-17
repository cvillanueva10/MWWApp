//
//  ViewController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/3/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Most Wanted Week"
        navigationController?.navigationBar.isTranslucent = false
        
        
        let pageTitle = UILabel(frame: CGRect(x:0,y:0,width:100,height:100))
        pageTitle.text = "Most Wanted Week"
        pageTitle.font = UIFont.systemFont(ofSize:20)
        pageTitle.textColor = UIColor.white
        navigationItem.titleView = pageTitle
        
        setupCollectionView()
        setupMenuBar()
        setupNavButtons()
    }
    let cellId = "cellId"
    
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = UIColor.white
    
        //collectionView?.register(AnnouncementCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    
        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 75, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 75, 0)
        collectionView?.isPagingEnabled = true
    }
    
    
    let menuBar: MenuBar = {
        let menu = MenuBar()
        return menu
    }()
    
    func setupNavButtons(){
        let menuImage = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        let menuButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(menuHandler))
        navigationItem.leftBarButtonItem = menuButtonItem
        menuButtonItem.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        
    }
    lazy var settingsController: SettingsController = {
        let controller = SettingsController()
        controller.homeController = self
        return controller
    }()
    
    func menuHandler(){
        settingsController.showSettings()
    }
    
    func showControllerForMenuTab(menutab: MenuTab){
        let dummyTabViewController = UIViewController()
        dummyTabViewController.navigationItem.title = menutab.tabLabelName
        dummyTabViewController.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.pushViewController(dummyTabViewController, animated: true)
    }
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|",views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(75)]|",views: menuBar)
    
    }

    var announcementObjs: [Announcement] = {
        var chrisProfile = Profile()
        chrisProfile.profileImageName = "ChrisProfilePic"
        chrisProfile.profileName = "Chris Villanueva"
        
        var nhungProfile = Profile()
        nhungProfile.profileImageName =  "NhungProfilePic"
        nhungProfile.profileName = "Nhung Nguyen"
        
        var leoProfile = Profile()
        leoProfile.profileImageName = "LeoProfilePic"
        leoProfile.profileName = "Leo"
        
        var nhungAnnouncement = Announcement()
        nhungAnnouncement.text = "Julian's a bitch"
        nhungAnnouncement.timeStamp = "Sunday, July 9, 2017 at 3:59pm"
        nhungAnnouncement.profile = nhungProfile
        
        var leoAnnouncement = Announcement()
        leoAnnouncement.text = "Test #3"
        leoAnnouncement.timeStamp = "Sunday, July 9, 2017 at 4:00pm"
        leoAnnouncement.profile = leoProfile
        
        var chrisAnnouncement = Announcement()
        chrisAnnouncement.text = "Test #2"
        chrisAnnouncement.timeStamp = "Sunday, July 9, 2017 at 4:01pm"
        chrisAnnouncement.profile = chrisProfile
        
        var chrisTestAnnouncement = Announcement()
        chrisTestAnnouncement.text = "Test"
        chrisTestAnnouncement.timeStamp = "Sunday, July 9, 2017 at 3:40pm"
        chrisTestAnnouncement.profile = chrisProfile
        
        return [chrisTestAnnouncement, nhungAnnouncement, leoAnnouncement, chrisAnnouncement]
    }()
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstrait?.constant = scrollView.contentOffset.x / 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        let colors: [UIColor] = [.red, .purple, .blue]
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: view.frame.width, height: view.frame.height - 75 )
    }
    
//    override func collectionView(_ collectionView: UICollectionView,
//        numberOfItemsInSection section: Int) -> Int {
//        
//        return announcementObjs.count
//    }
//    
//    override func collectionView(_ collectionView: UICollectionView,
//        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
//        {
//       let cell =
//            collectionView.dequeueReusableCell(withReuseIdentifier: "cellId",
//            for: indexPath) as! AnnouncementCell
//            
//            cell.announcement = announcementObjs[indexPath.item]
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 200)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}

