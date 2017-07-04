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
    
    
    func fetchPosts (objects: [PFObject],
                     complitionQueue: DispatchQueue,
                     complition: @escaping ([Post]?, [PFObject]?, Error?) -> ()) {
                var postArray: [Post] = []
                objects.forEach({ (post) in
                    if let user = post["user"] as? PFUser {
                        if let name = user["fbName"] as? String, let description = post["descriptions"] as? String {
                            if let userPhoto = user["fbPhoto"] as? PFFile {
                                do {
                                    let photoData = try userPhoto.getData()
                                    if let image = UIImage(data: photoData) {
                                        let fetchedPost = Post(name: name, description: description, photo: image)
                                        postArray.append(fetchedPost)
                                        complitionQueue.async {
                                            complition(postArray, objects, nil)
                                        }
                                    }
                                } catch let error {
                                    complitionQueue.async {
                                        complition(nil, nil, error)
                                    }
                                }
                            } else if user["fbPhoto"] == nil {
                                print("fbPhoto taki nil.")
                            } else {
                                print("Не знаю что тут писать")
                            }
                        }
                    }
                })
    }
    
    /*
    func fetchPosts (query: PFQuery<PFObject>,
                     runQueue: DispatchQueue,
                     complitionQueue: DispatchQueue,
                     complition: @escaping ([Post]?, [PFObject]?, Error?) -> ()) {
        query.includeKey("user")
        query.order(byAscending: "createdAt")
        runQueue.async {
            do {
                let objects = try query.findObjects()
                var postArray: [Post] = []
                objects.forEach({ (post) in
                    if let user = post["user"] as? PFUser {
                        if let name = user["fbName"] as? String, let description = post["descriptions"] as? String {
                            if let userPhoto = user["fbPhoto"] as? PFFile {
                                do {
                                    let photoData = try userPhoto.getData()
                                    if let image = UIImage(data: photoData) {
                                        let fetchedPost = Post(name: name, description: description, photo: image)
                                        postArray.append(fetchedPost)
                                        complitionQueue.async {
                                            complition(postArray, objects, nil)
                                        }
                                    }
                                } catch let error {
                                    complitionQueue.async {
                                        complition(nil, nil, error)
                                    }
                                }
                            } else if user["fbPhoto"] == nil {
                                print("fbPhoto taki nil.")
                            } else {
                                print("Не знаю что тут писать")
                            }
                        }
                    }
                })
            } catch let error {
                complitionQueue.async {
                    complition(nil, nil, error)
                }
            }
        }
    }
    */

    
}
