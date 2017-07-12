//
//  CurrentUserConfig.swift
//  Wooower
//
//  Created by vlad on 11.07.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import Parse


class CurrentUserConfig {
    
    static var sharedInstance = CurrentUserConfig()
    private init () {}
    
    func fetchUser (pfUser: PFUser?, complition: @escaping (_ dict: Dictionary<String,Any>?)->()) {
        if let user = pfUser {
            if let username = user["username"] as? String,
                let fbName = user["fbName"] as? String,
                let fbID = user["fbID"] as? String,
                let createdAt = user.createdAt,
                let updatedAt = user.updatedAt,
                let objectId = user.objectId,
                let fbPhoto = user["fbPhoto"] as? PFFile {
                
                fbPhoto.getDataInBackground(block: { (data, error) in
                    var resultDictionary: Dictionary<String,Any> = [:]
                    if let data = data {
                        if let image = UIImage(data: data) {
                            resultDictionary["fbPhoto"] = image
                            resultDictionary["username"] = username
                            resultDictionary["fbName"] = fbName
                            resultDictionary["fbID"] = fbID
                            resultDictionary["updatedAt"] = updatedAt
                            resultDictionary["createdAt"] = createdAt
                            resultDictionary["objectId"] = objectId
                            kMainQueue.async {
                                complition(resultDictionary)
                                
                            }
                        }
                    }
                    
                })
            }
        }
    }
    
}

