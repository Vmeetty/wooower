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
    
    static func fetchPosts () -> [String] {
        var postObjects: [String] = []
        let query = PFQuery(className: "Post")
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                postObjects = objects.map({ (postPfObject) -> String in
                    return postPfObject["descriptions"] as? String ?? "Ups"
                })
            }
        }
        return postObjects
    }
    
}
