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
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var firstAndLastNameLabel: UILabel!
    
    var post: Post? {
        didSet {
            descriptionTextView.text = post?.description
            avatarImage.image = post?.avatarImage
            firstAndLastNameLabel.text = (post?.firstName)! + " " + (post?.lastName)!
        }
    }

}
