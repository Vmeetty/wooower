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
    
    func configComments (activity: PFObject?,
                          runQueue: DispatchQueue,
                          complitionQueue: DispatchQueue,
                          complition: @escaping ([Comment]?, Error?) -> ()) {
        
        let commentRelation = activity?.relation(forKey: "comments")
        let query = commentRelation?.query()
        query?.includeKey("user")
        query?.order(byAscending: "createdAt")
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

}    

