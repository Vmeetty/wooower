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
    
    func configComments2 (activity: PFObject?,
                          runQueue: DispatchQueue,
                          complitionQueue: DispatchQueue,
                          complition: @escaping (Comment?, Error?) -> ()) {
        
        let commentRelation = activity?.relation(forKey: "comments")
        let query = commentRelation?.query()
        query?.includeKey("user")
        query?.order(byAscending: "createdAt")
        runQueue.async {
            do {
                if let objects = try query?.findObjects() {
                    objects.forEach({ (obj) in
                        if let userName = (obj["user"] as? PFUser)?.username {
                            let text = obj["text"] as! String
                            let comment = Comment(name: userName, text: text)
                            complitionQueue.async {
                                complition(comment, nil)
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
    
    func configComments (activity: PFObject?, sender: Any) {
        let commentRelation = activity?.relation(forKey: "comments")
        let query = commentRelation?.query()
        query?.includeKey("user")
        query?.order(byAscending: "createdAt")
        query?.findObjectsInBackground(block: { (comments, error) in
            if let objects = comments {
                objects.forEach({ (obj) in
                    if let userName = (obj["user"] as? PFUser)?.username {
                        if let controller = sender as? AllCommentsViewController {
                            let comment = Comment(name: userName, text: (obj["text"] as! String))
                            controller.comments.append(comment)
                        }
                        if let controller = sender as? ActivityViewController {
                            let comment = Comment(name: userName, text: (obj["text"] as! String))
                            controller.comments.append(comment)
                        }
                    }
                })
            }
        })
    }
    
}
