//
//  File.swift
//  Wooower
//
//  Created by vlad on 01.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import Parse

class Fetching {
    
    static func fetchPosts () -> [PFObject] {
        var postObjects: [PFObject] = []
        let query = PFQuery(className: "Post")
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                for object in objects {
                    postObjects.append(object)
                }
            }
        }
        return postObjects
    }
    
}
