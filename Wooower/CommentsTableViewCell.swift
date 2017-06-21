//
//  CommentsTableViewCell.swift
//  Wooower
//
//  Created by vlad on 09.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var commentAvatarView: UIView!
    @IBOutlet weak var commentAvatarImageView: UIImageView!
    @IBOutlet weak var commentNameLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!

    var comment: Comment? {
        didSet {
            configCommentCell()
        }
    }
    
    func configCommentCell () {
        commentNameLabel.text = comment?.name
        commentTextLabel.text = comment?.text
    }

}
