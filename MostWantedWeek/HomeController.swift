//
//  ViewController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/3/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    lazy var menuBar: MenuBar = {
        let menu = MenuBar()
        menu.homeController = self
        return menu
    }()
    
    lazy var settingsController: SettingsController = {
        let controller = SettingsController()
        controller.homeController = self
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Home"
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let initialIndex = IndexPath(item: 1, section: 0)
        collectionView?.scrollToItem(at: initialIndex, at: .centeredHorizontally, animated: false)    }

    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        collectionView?.backgroundColor = UIColor.white
    
        collectionView?.register(DefaultCell.self, forCellWithReuseIdentifier: cellId)

        collectionView?.contentInset = UIEdgeInsetsMake(0, 0, 75, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 75, 0)
        collectionView?.isPagingEnabled = true
        
        menuBar.horizontalBarLeftAnchorConstrait?.constant = view.frame.width / 3
    }
    
    func setupNavButtons(){
        let menuImage = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        let menuButtonItem = UIBarButtonItem(image: menuImage, style: .plain, target: self, action: #selector(menuHandler))
        navigationItem.leftBarButtonItem = menuButtonItem
        menuButtonItem.imageInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    }
    
    private func setupMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|",views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(75)]|",views: menuBar)
    }
    
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
    
    func scrollToSectionIndex(sectionIndex: Int){
        let indexPath = IndexPath(item: sectionIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }

    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstrait?.constant = scrollView.contentOffset.x / 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: view.frame.width, height: view.frame.height - 75 )
    }
    
}

