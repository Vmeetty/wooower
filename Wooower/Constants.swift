//
//  Constants.swift
//  Wooower
//
//  Created by vlad on 12.07.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit


// queues constants
let kUserInteractiveGQ = DispatchQueue.global(qos: .userInteractive)
let kUserInitiatedGQ = DispatchQueue.global(qos: .userInitiated)
let kUtilityGQ = DispatchQueue.global(qos: .utility)
let kBgQ = DispatchQueue.global(qos: .background)
let kDgQ = DispatchQueue.global()
let kMainQueue = DispatchQueue.main

// cell IDs
let cellID = "wooowerCell"
let addCellID = "addCell"
let commentCellID = "commentCell"
let allCommentCellID = "allCommentCellID"

// vc IDs
let activityViewController = "ActivityViewController"

// segue IDs
let profileSegueID = "ProfileViewController"
let allCommentsSegue = "AllCommentsViewController"
let mapSegue = "MapViewController"

// dataBase "Post" class culomns
let postParse = "Post"
let postDescription = "descriptions"
let postUser = "user"
let postLongitude = "longitude"
let postLatitude = "latitude"
let postCreatedAt = "createdAt"
let postPicture = "picture"
let postComments = "comments"

// dataBase "User" class culomns
let userName = "username"
let userFbName = "fbName"
let userFbPhoto = "fbPhoto"
let userComments = "comments"
let userFbID = "fbID"
let userObjectId = "objectId"
let userCreatedAt = "createdAt"
let userUpdatedAt = "updatedAt"

// let dataBase "Comment" class culomns
let commentParse = "Comment"
let commentTxt = "text"
let commentUser = "user"
let commentPost = "post"

// fetched USER DICTIONARY KEYS
//***** same as dataBase "User" class culomns, but also it has such keys as:
let allUserComments = "allUserComments"








