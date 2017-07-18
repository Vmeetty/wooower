//
//  File.swift
//  Wooower
//
//  Created by vlad on 01.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import Parse

class FetchingPosts {
    
    static let sharedInstance = FetchingPosts()
    private init () {}
    
    
    func fetchPosts (objects: [PFObject], complition: @escaping ([Post]?, [PFObject]?, Error?) -> ()) {
        var postArray: [Post] = []
        kUserInitiatedGQ.async {
            objects.forEach({ (post) in
                if let user = post["user"] as? PFUser {
                    if let name = user["fbName"] as? String, let description = post["descriptions"] as? String {
                        var photo = UIImage(named: "123")
                        if let userPhoto = user["fbPhoto"] as? PFFile {
                            do {
                                let photoData = try userPhoto.getData()
                                if let image = UIImage(data: photoData) {
                                    photo = image
                                }
                            } catch let error {
                                kMainQueue.async {
                                    complition(nil, nil, error)
                                }
                            }
                        } else if user["fbPhoto"] == nil {
                            print("fbPhoto taki nil.")
                        }
                        let fetchedPost = Post(name: name, description: description, photo: photo!)
                        postArray.append(fetchedPost)
                        kMainQueue.async {
                            complition(postArray, objects, nil)
                        }
                    }
                }
            })
        }
        
    }
    
}
