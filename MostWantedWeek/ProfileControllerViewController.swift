//
//  ProfileControllerViewController.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/26/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.cornerRadius = 75
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profileUserNameLabel: UILabel = {
        let label = UILabel()
        //label.backgroundColor = .blue
        label.textAlignment = .center
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let organizationNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
         view.backgroundColor = .white
        
        checkIfUserIsLoggedIn()
        setupView()
       
    }
    
    func setupView() {
        
        view.addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        view.addSubview(profileUserNameLabel)
        profileUserNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileUserNameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20).isActive = true
        profileUserNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        profileUserNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(organizationNameLabel)
        organizationNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        organizationNameLabel.topAnchor.constraint(equalTo: profileUserNameLabel.bottomAnchor, constant: 10).isActive = true
        organizationNameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        organizationNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogout), with: nil, afterDelay: 0)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.profileUserNameLabel.text = dictionary["name"] as? String
                }
            }, withCancel: nil)
        }
    }
    
    func handleLogout(){
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        //let loginController = LoginController()
        navigationController?.popViewController(animated: true)
        //self.present(loginController, animated: true, completion: nil)
    }
}
