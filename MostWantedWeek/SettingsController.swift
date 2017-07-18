//
//  SettingsController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/9/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class SettingsController: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    let dimView = UIView()
    
    let logoView: UIImageView = {
        let logo = UIImageView()
        logo.backgroundColor = UIColor.red
        return logo
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        
        return cv
    }()
    
    var homeController: HomeController?
    
    var menuTabObjs: [MenuTab] = {
        var aboutTab = MenuTab(logoName: "about", labelName: "About MWW")
        var brosTab = MenuTab(logoName: "bros", labelName: "Meet the Bros")
        var tieTab = MenuTab(logoName: "tiegame", labelName: "Charm-A-Sig")
        var scTab = MenuTab(logoName: " ", labelName: "Star and Crescent")
        var shirtTab = MenuTab(logoName: " ", labelName: "Shirt Orders")
        var settingsTab = MenuTab(logoName: " ", labelName: "Settings")
        
        return [aboutTab, brosTab, tieTab, scTab, shirtTab, settingsTab]
    }()

    func showSettings(){

        if let window = UIApplication.shared.keyWindow{
            dimView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            dimView.alpha = 0
            
            dimView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                action: #selector(dismissHandler)))
            
            window.addSubview(dimView)
            window.addSubview(collectionView)
            window.addSubview(logoView)
           
            collectionView.frame = CGRect(x: -200, y: 100, width: 200, height: window.frame.height - 100)
            logoView.frame = CGRect(x: -200, y: 0, width: 200, height: 100)
            
            dimView.frame = window.frame
            
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.dimView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: 100, width: 200, height: window.frame.height - 100)
                self.logoView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
            }, completion: nil)
        }
    }

    func dismissHandler(menutab: MenuTab){
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.dimView.alpha = 0
            self.collectionView.frame = CGRect(x: -200, y: 100, width: 200, height: 2000)
            self.logoView.frame = CGRect(x: -200, y: 0, width: 200, height: 100)
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuTabObjs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell

        cell.menuTab = menuTabObjs[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.dimView.alpha = 0
        self.collectionView.frame = CGRect(x: -200, y: 100, width: 200, height: 2000)
        self.logoView.frame = CGRect(x: -200, y: 0, width: 200, height: 100)
    }) {(completion: Bool) in
    
        let menutab = self.menuTabObjs[indexPath.item]
        self.homeController?.showControllerForMenuTab(menutab: menutab)
        }
    }

    override init(){
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
}
