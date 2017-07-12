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
                    var commentsArray: [Comment] = []
                    objects.forEach({ (obj) in
                        if let userName = (obj["user"] as? PFUser)?.username {
                            let text = obj["text"] as! String
                            let comment = Comment(name: userName, text: text)
                            commentsArray.append(comment)
                            complitionQueue.async {
                                complition(commentsArray, nil)
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
            let commentRelation = post.relation(forKey: "comments")
            let query = commentRelation.query()
            query.includeKey("user")
            query.order(byAscending: "createdAt")
            resultQuery = query
        } else if let user = object as? PFUser {
            let commentRelation = user.relation(forKey: "comments")
            let query = commentRelation.query()
            resultQuery = query
        }
       return resultQuery!
    }

}

