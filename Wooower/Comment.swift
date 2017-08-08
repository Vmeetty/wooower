//
//  Comment.swift
//  Wooower
//
//  Created by vlad on 09.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit

class Comment {
    
    let name: String
    let text: String
    let userPhoto: UIImage
    
    init(name: String, text: String, userPhoto: UIImage) {
        self.name = name
        self.text = text
        self.userPhoto = userPhoto
    }
    
}
