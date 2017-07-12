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
            if let username = user[userName] as? String,
                let fbName = user[userFbName] as? String,
                let fbID = user[userFbID] as? String,
                let createdAt = user.createdAt,
                let updatedAt = user.updatedAt,
                let objectId = user.objectId,
                let fbPhoto = user[userFbPhoto] as? PFFile {
                
                fbPhoto.getDataInBackground(block: { (data, error) in
                    var resultDictionary: Dictionary<String,Any> = [:]
                    if let data = data {
                        if let image = UIImage(data: data) {
                            resultDictionary[userFbPhoto] = image
                            resultDictionary[userName] = username
                            resultDictionary[userFbName] = fbName
                            resultDictionary[userFbID] = fbID
                            resultDictionary[userUpdatedAt] = updatedAt
                            resultDictionary[userCreatedAt] = createdAt
                            resultDictionary[userObjectId] = objectId
                            kMainQueue.async {
                                ConfigCommentView.sharedInstance.configComments(object: pfUser, runQueue: kUserInitiatedGQ, complitionQueue: kMainQueue, complition: { (comments, error) in
                                    if let comments = comments {
                                        resultDictionary[allUserComments] = comments
                                        complition(resultDictionary)
                                    }
                                })
                            }
                        }
                    }
                    
                })
            }
        }
    }
    
}

