//
//  TableViewCell.swift
//  Wooower
//
//  Created by vlad on 01.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    var post: Post? {
        didSet {
            descriptionTextView.text = post?.description
            avatarImage.image = UIImage(named: "user")
            nameLabel.text = post?.name
        }
    }
    

}
