//
//  ConfigCommentView.swift
//  Wooower
//
//  Created by vlad on 09.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import Parse
import UIKit

class ConfigCommentView {
    
    static let sharedInstance = ConfigCommentView()
    private init () {}
    
    func configComments (object: Any?,
                         runQueue: DispatchQueue,
                         complitionQueue: DispatchQueue,
                         complition: @escaping ([Comment]?, Error?) -> ()) {
        
        let query = configQuery(object: object)
        runQueue.async {
            do {
                if let objects = try query?.findObjects() {
                    let sortedObjects = objects.sorted(by: { (obj1, obj2) -> Bool in
                        return obj1.createdAt! > obj2.createdAt!
                    })
                    var commentsArray: [Comment] = []
                    sortedObjects.forEach({ (obj) in
                        if let user = obj[commentUser] as? PFUser {
                            let userName = user.username
                            let text = obj[commentTxt] as! String
                            var photo = UIImage(named: "123")
                            if let userPhoto = user[userFbPhoto] as? PFFile {
                                do {
                                    let imageData = try userPhoto.getData()
                                    if let image = UIImage(data: imageData) {
                                        photo = image
                                    }
                                } catch let error {
                                    print(error)
                                }
                            }
                            if let userPhoto = photo, let name = userName {
                                let comment = Comment(name: name, text: text, userPhoto: userPhoto)
                                commentsArray.append(comment)
                                complitionQueue.async {
                                    complition(commentsArray, nil)
                                }
                            }
                        }
                    })
                }
            } catch let error {
                complitionQueue.async {
                    complition(nil, error)
                }
            }
        }
    }
    
    func configQuery (object: Any?) ->  PFQuery<PFObject>? {
        var resultQuery: PFQuery<PFObject>? = nil
        if let post = object as? PFObject {
            let commentRelation = post.relation(forKey: postComments)
            let query = commentRelation.query()
            query.includeKey(commentUser)
            query.order(byAscending: commentCreatedAt)
            resultQuery = query
        } else if let user = object as? PFUser {
            let commentRelation = user.relation(forKey: postComments)
            let query = commentRelation.query()
            resultQuery = query
        }
        return resultQuery!
    }
    
}

