//
//  NewAnnouncementControllerViewController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/31/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

class NewAnnouncementController: UIViewController {
    
    lazy var announcementTextField : UITextView = {
        let text = UITextView()
        text.font = UIFont.systemFont(ofSize: 20)
        text.isEditable = true
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let postButtonView : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.rgb(red: 200, green: 32, blue: 31)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.addTarget(self, action: #selector(handleCreatePost), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes =
            [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.tintColor = .white
        navigationItem.title = "New Announcement"
        view.backgroundColor = .white
        
        setupAnnouncementTextField()
        setupPostButtonView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        announcementTextField.becomeFirstResponder()
    }
    
    func handleCreatePost(){
        
        if announcementTextField.text.isEmpty{
            print("Message is empty")
            return
        }
        let date = Date()
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium

        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        let ref = Database.database().reference().child("announcements")
        let childRef = ref.childByAutoId()
        let timeStamp: Int = Int(NSDate().timeIntervalSince1970)
        let childRefString = String(describing: childRef)
        let values = ["text" : self.announcementTextField.text!, "fromId" : uid, "timeStamp" : timeStamp, "timeFormatted" : formatter.string(from: date), "numOfLikes" : 0, "childRef" : childRefString] as [String : Any]
        childRef.updateChildValues(values)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupAnnouncementTextField(){
        view.addSubview(announcementTextField)
        
        announcementTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        announcementTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        announcementTextField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        announcementTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/2).isActive = true
    }
    
    func setupPostButtonView(){
        view.addSubview(postButtonView)
        
        postButtonView.rightAnchor.constraint(equalTo: announcementTextField.rightAnchor).isActive = true
        postButtonView.topAnchor.constraint(equalTo: announcementTextField.bottomAnchor, constant: 20).isActive = true
        postButtonView.widthAnchor.constraint(equalToConstant: 75).isActive = true
        postButtonView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
}
