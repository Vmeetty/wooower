//
//  Profile.swift
//  Wooower
//
//  Created by vlad on 12.07.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit

class Profile {
    
    var userName: String?
    var userPhoto: UIImage?
    var commentsCount: String?
    
    init(userName: String, userPhoto: UIImage, commentsCount: String) {
        self.userName = userName
        self.userPhoto = userPhoto
        self.commentsCount = commentsCount
    }
    
    
//    var userName: String?
//    var userPhoto: UIImage?
//    var eventsCount: String?
//    var commentsCount: String?
//    
//    init(userName: String, userPhoto: UIImage,eventsCount: String, commentsCount: String) {
//        self.userName = userName
//        self.userPhoto = userPhoto
//        self.eventsCount = eventsCount
//        self.commentsCount = commentsCount
//    }
    
}
