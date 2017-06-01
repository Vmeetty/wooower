//
//  Post.swift
//  Wooower
//
//  Created by vlad on 01.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit

class Post {

    var firstName: String
    var lastName: String
    var avatarImage: UIImage
    var description: String
    
//    init(description: String) {
//        self.description = description
//    }
    
    init(firstName: String, lastName: String, avatarImage: UIImage, description: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.avatarImage = avatarImage
        self.description = description    
    }
    
}
