//
//  File.swift
//  Wooower
//
//  Created by vlad on 01.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import Parse
import MapKit

class FetchingPosts {
    
    var postObjects:[PFObject]?
    
    static let sharedInstance = FetchingPosts()
    private init () {}
    
    func fetchPosts (complition: @escaping ([PFObject]?, [Post]?, Bool, Error?)->()) {
        let query = PFQuery(className: postParse)
        query.includeKey(postUser)
        query.order(byAscending: postCreatedAt)
        kUserInitiatedGQ.async {
            do {
                let objects = try query.findObjects()
                kMainQueue.async {
                    if objects.count == 0 {
                        complition(nil, nil, false, nil)
                    } else {
                        let sortedObjects = objects.sorted(by: { (obj1, obj2) -> Bool in
                            return obj1.createdAt! > obj2.createdAt!
                        })
                        self.fetchPosts(objects: sortedObjects, complition: { (posts, objects, error) in
                            if let objects = objects, let posts = posts {
                                complition(objects, posts, true, nil)
                            }
                        })
                    }
                }
            } catch {
                kMainQueue.async {
                    Spinners.sharedInstance.removeLoadingScreen()
//                    Spinners.sharedInstance.setCapView(sender: self, complition: { (labelText, view) in
//                        labelText.text = "Unknown error"
//                        view.addSubview(labelText)
//                        self.myTableView.addSubview(view)
//                    })
                }
            }
        }
    }
    
    
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
