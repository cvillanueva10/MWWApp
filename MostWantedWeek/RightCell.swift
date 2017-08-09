//
//  RightCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/18/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

class DirectoryCell: BaseCell{
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        label.layer.cornerRadius = 5
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 1
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        layer.cornerRadius = 5
        addSubview(dateLabel)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: dateLabel)
        addConstraintsWithFormat(format: "V:|[v0]|", views: dateLabel)
    }
}

class RightCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let cellId = "cellId"
    
    let dates = ["Before MWW", "Monday, October 16", "Tuesday, October 17", "Wednesday, October 18", "Thursday, October 19", "Friday, October 20"]
    let dateIds = ["Before", "M", "T", "WED", "THUR", "FRI"]
    
    let dimView = UIView()
    
    lazy var eventView: EventMainView = {
        let view = EventMainView()
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        //observeEvents()
        
        backgroundColor = UIColor.rgb(red: 225, green: 225, blue: 225)
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0)
        collectionView.register(DirectoryCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    
    func handleShowEvents(){
        
        addSubview(dimView)
        addSubview(eventView)
        
        let eventViewHeight = frame.height * 0.75
        eventView.frame = CGRect(x: 0, y: frame.height + eventViewHeight, width: frame.width, height: eventViewHeight)
        
        if let window = UIApplication.shared.keyWindow {
            dimView.frame = window.frame
        }
        dimView.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
        dimView.alpha = 0
        
        dimView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
    
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let eventViewHeight = self.frame.height * 0.75
            
            self.eventView.frame = CGRect(x: 0, y: self.frame.height - eventViewHeight, width: self.frame.width, height: eventViewHeight)
            self.dimView.alpha = 1
            
        }, completion: nil)
    }
    
    func handleDismiss() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
            let eventViewHeight = self.frame.height * 0.75
            
            self.eventView.frame = CGRect(x: 0, y: self.frame.height + eventViewHeight, width: self.frame.width, height: eventViewHeight)
            self.dimView.alpha = 0
            
        }, completion: nil)

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DirectoryCell
        cell.dateLabel.text = dates[indexPath.item]
 //       cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShowEvents)))
        return cell
    }
    
    let eventMainView = EventMainView()
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        handleShowEvents()
        eventMainView.observeEvents(dateId: dateIds[indexPath.item])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        if let eventDescription = eventObjs[indexPath.item].eventDescription{
        //
        //            let rect = NSString(string: eventDescription).boundingRect(with: CGSize(width: frame.width, height: 2000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
        //
        //            let knownHeight: CGFloat = 40 + 40 + 30
        //
        //            return CGSize(width: frame.width, height: rect.height + knownHeight + 40)
        //        }
        //        return CGSize(width: frame.width, height: frame.height * 0.5)
        
        return CGSize(width: frame.width * 0.8, height: frame.height * 0.12)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}

