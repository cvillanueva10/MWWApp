//
//  ViewController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/3/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let centerCellId = "centerCellId"
    let leftCellId = "leftCellId"
    let rightCellId = "rightCellId"
    
    lazy var lowerMenuBar: LowerMenuBar = {
        let menu = LowerMenuBar()
        menu.homeController = self
        return menu
    }()
    
    lazy var menuController: MenuController = {
        let controller = MenuController()
        controller.homeController = self
        return controller
    }()
    
    let upperMenuBar: UpperMenuBar = {
        let ub = UpperMenuBar()
        ub.backgroundColor = UIColor.rgb(red: 200, green: 32, blue: 31)
        return ub
    }()
    
    let menuButtonImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        iv.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        iv.contentMode = .scaleAspectFill
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false
        
        let pageTitle = UILabel(frame: CGRect(x:0,y:0,width:100,height:100))
        pageTitle.text = "Most Wanted Week"
        pageTitle.font = UIFont.boldSystemFont(ofSize: 24)
        pageTitle.textColor = UIColor.white
        navigationItem.titleView = pageTitle
        
        loadPageView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadPageView()
        
        let initialIndex = IndexPath(item: 1, section: 0)
        collectionView?.scrollToItem(at: initialIndex, at: .centeredHorizontally, animated: false)
        
    }
    
    func loadPageView(){
        setupCollectionView()
        setupUpperMenuBar()
        setupLowerMenuBar()
    }
    
    func setupCollectionView(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }

        collectionView?.backgroundColor = .white
        collectionView?.register(RightCell.self, forCellWithReuseIdentifier: rightCellId)
        collectionView?.register(CenterCell.self, forCellWithReuseIdentifier: centerCellId)
        collectionView?.register(LeftCell.self, forCellWithReuseIdentifier: leftCellId)
        collectionView?.contentInset = UIEdgeInsetsMake(35, 0, 50, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(35, 0, 50, 0)
        collectionView?.isPagingEnabled = true
        
        lowerMenuBar.horizontalBarLeftAnchorConstrait?.constant = view.frame.width / 3
    }
    
    private func setupUpperMenuBar(){
        
        upperMenuBar.setHeaderProfileImage()
        
        view.addSubview(upperMenuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: upperMenuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(35)]", views: upperMenuBar)
        
        upperMenuBar.writePostButton.addTarget(self, action: #selector(writeHandler), for: .touchUpInside)
        upperMenuBar.sideMenuBarButton.addTarget(self, action: #selector(menuHandler), for: .touchUpInside)
    }
    
    private func setupLowerMenuBar(){
        view.addSubview(lowerMenuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|",views: lowerMenuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]|",views: lowerMenuBar)
    }
    
    func menuHandler(){
        menuController.showSettings()
    }
    
    func writeHandler(){
        if Auth.auth().currentUser?.uid == nil {
            let loginController = LoginController()
            present(loginController, animated: true, completion: nil)
        } else {
            let newAnnouncementController = NewAnnouncementController()
            navigationController?.pushViewController(newAnnouncementController, animated: true)
        }
        
    }
    
    let profileController = ProfileController()
    let loginController = LoginController()
    
    func showControllerForMenuTab(menutab: MenuTab){
        let layout = UICollectionViewFlowLayout()
        let descriptionController = DescriptionController(collectionViewLayout: layout)
        let biographyController = BiographyController(collectionViewLayout: layout)
        
        descriptionController.navigationItem.title = menutab.tabLabelName
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.tintColor = .white
        
        if(menutab.tabLabelName == "About MWW" || menutab.tabLabelName == "Penny Wars" || menutab.tabLabelName == "Charm-A-Sig" || menutab.tabLabelName == "Star and Crescent"){
            descriptionController.tab = menutab
            navigationController?.pushViewController(descriptionController, animated: true)
        }
        else if (menutab.tabLabelName == "Profile"){
            if Auth.auth().currentUser?.uid == nil {
                present(loginController, animated: true, completion: nil)
            }
            else {
                navigationController?.pushViewController(profileController, animated: true)
            }
        }
        else if (menutab.tabLabelName == "Meet the Bros"){
            navigationController?.pushViewController(biographyController, animated: true)
        }
    }
    
    func scrollToSectionIndex(sectionIndex: Int){
        let indexPath = IndexPath(item: sectionIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        lowerMenuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        lowerMenuBar.horizontalBarLeftAnchorConstrait?.constant = scrollView.contentOffset.x / 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier: String
        if indexPath.item == 0 {
            identifier = leftCellId
        }
        else if indexPath.item == 2 {
            identifier = rightCellId
        }
        else{
            identifier = centerCellId
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50 - 35)
    }
    
}

