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
    
    func configComments (activity: PFObject?, controller: Any?) {
        let commentRelation = activity?.relation(forKey: "comments")
        let query = commentRelation?.query()
        query?.includeKey("user")
        query?.findObjectsInBackground(block: { (comments, error) in
            if let objects = comments {
                objects.forEach({ (obj) in
                    if let userName = (obj["user"] as? PFUser)?.username {
                        if let controller = controller as? ActivityViewController {
                            controller.nameComment.text = userName
                            controller.textComment.text = (obj["text"] as! String)
                        }
                    }
                })
            }
        })
    }
    
}
