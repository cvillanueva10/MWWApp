//
//  ApiService.swift
//  MostWantedWeek
//
//  Created by Christopher Villanueva on 7/23/17.
//  Copyright © 2017 Christopher Villanueva. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    func fetchDescriptions(tabName: String, completion: @escaping ([Description]) -> ()){
        let url = URL(string: "file:///Users/christophervillanueva/Desktop/description_info.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                var descriptionObjs = [Description]()
                //
                for dictionary in json as! [[String: AnyObject]] {
                        let name = tabName
                        let subdictionary = dictionary[name]
                        let descriptionobj = Description()
                        descriptionobj.descriptionText = subdictionary?["description"] as? String
                        descriptionobj.headerImage = subdictionary?["headerimage"] as? String
                        descriptionobj.headerLabel = subdictionary?["headerlabel"] as? String
                        
                        descriptionObjs.append(descriptionobj)
                }
            
                DispatchQueue.main.async(execute: {
                    completion(descriptionObjs)
                })
            } catch let jsonError{
                print(jsonError)
            }
            }.resume()
    }
}
