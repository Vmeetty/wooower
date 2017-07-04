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

    var name: String
    var userPhoto: UIImage
    var description: String
    
//    init(name: String, description: String) {
//        self.name = name
//        self.description = description
//    }
    
    init(name: String, description: String, photo: UIImage) {
        self.name = name
        userPhoto = photo
        self.description = description
    }
    
}
