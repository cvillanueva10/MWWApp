//
//  EventCell.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/18/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

class EventMainView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    let bodyId = "bodyId"
    var dateId: String?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        loadDataFromEachDay()
        setupCollectionView()
  
    }
    
    func loadDataFromEachDay(){
        observeEvents(dateId: "M")
        observeEvents(dateId: "T")

    }
    
    func setupCollectionView(){
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.register(EventBodyCell.self, forCellWithReuseIdentifier: bodyId)
    }
    
    var eventObjs = [Event]()
    
    func observeEvents(dateId: String){
  
        let ref = Database.database().reference().child("schedule").child(dateId)
        
        ref.observe(.childAdded, with: { (snapshot) in
            
            self.eventObjs.removeAll()
            
            if let dictionary = snapshot.value as? [String: Any] {
                let event = Event()
                event.setValuesForKeys(dictionary)
                
                self.eventObjs.append(event)
                self.eventObjs.sort(by: { (e1, e2) -> Bool in
                    (e1.orderNum?.intValue)! < (e2.orderNum?.intValue)!
                })

                DispatchQueue.main.async {

                    self.collectionView.reloadData()
                }
                

            }
        }, withCancel: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bodyId, for: indexPath) as! EventBodyCell
        cell.event = eventObjs[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventObjs.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EventHeaderCell: BaseCell {
    
    override func setupViews() {
        backgroundColor = .red
    }
    
}

class EventBodyCell: BaseCell {
    
    var event: Event? {
        didSet{
            self.eventDate.text = event?.date
            self.eventName.text = event?.name
            self.eventLocation.text = event?.location
            self.eventTime.text = event?.time
            self.eventDescription.text = event?.eventDescription
        }
    }
    
    let eventDate: UILabel = {
        let date = UILabel()
        date.font = UIFont.boldSystemFont(ofSize: 26)
        date.layer.borderColor = UIColor.black.cgColor
        date.layer.borderWidth = 0.5
        date.textAlignment = .center
        date.backgroundColor = UIColor.rgb(red: 200, green: 31, blue: 32)
        date.textColor = .white
        date.translatesAutoresizingMaskIntoConstraints = false
        return date
    }()
    
    let eventName: UILabel = {
        let name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 24)
        name.textAlignment = .center
        name.layer.borderColor = UIColor.black.cgColor
        name.layer.borderWidth = 0.5
        name.backgroundColor = .white
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    let eventTime: UILabel = {
        let time = UILabel()
        time.textAlignment = .center
        time.layer.borderColor = UIColor.black.cgColor
        time.layer.borderWidth = 0.5
        time.font = UIFont.boldSystemFont(ofSize: 16)
        time.translatesAutoresizingMaskIntoConstraints = false
        return time
    }()
    
    let eventLocation: UILabel = {
        let location = UILabel()
        location.textAlignment = .center
        location.layer.borderColor = UIColor.black.cgColor
        location.layer.borderWidth = 0.5
        location.font = UIFont.boldSystemFont(ofSize: 16)
        location.translatesAutoresizingMaskIntoConstraints = false
        return location
    }()
    
    let eventDescription: UITextView = {
        let description = UITextView()
        description.font = UIFont.systemFont(ofSize: 14)
        description.layer.borderColor = UIColor.black.cgColor
        description.layer.borderWidth = 0.5
        description.isEditable = false
        description.isScrollEnabled = false
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()
    
    override func setupViews() {
        addSubview(eventDate)
        addSubview(eventName)
        addSubview(eventTime)
        addSubview(eventLocation)
        addSubview(eventDescription)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: eventDate)
        addConstraintsWithFormat(format: "H:|[v0]|", views: eventName)
        addConstraintsWithFormat(format: "H:[v0(\(frame.width/2))]|", views: eventTime)
        addConstraintsWithFormat(format: "H:|[v0]|", views: eventDescription)
        
        let nameHeight = frame.height * 0.2
        let timeLocationHeight = frame.height * 0.15
        
        addConstraintsWithFormat(format: "V:|[v0(\(nameHeight))]-0-[v1(\(timeLocationHeight))]-0-[v2]|", views: eventName, eventTime, eventDescription)
        
        addConstraint(NSLayoutConstraint(item: eventLocation, attribute: .left, relatedBy: .equal, toItem: eventName, attribute: .left, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: eventLocation, attribute: .top, relatedBy: .equal, toItem: eventTime, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: eventLocation, attribute: .width, relatedBy: .equal, toItem: eventTime, attribute: .width, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: eventLocation, attribute: .height, relatedBy: .equal, toItem: eventTime, attribute: .height, multiplier: 1, constant: 0))
        
    }
}
