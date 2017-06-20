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

    var object: PFObject? {
        didSet {
            ConfigCommentView.sharedInstance.configComments2(activity: object, runQueue: DispatchQueue.global(qos: .userInitiated), complitionQueue: DispatchQueue.main) { (comment, error) in
                if let comment = comment {
                    self.commentNameLabel.text = comment.name
                    self.commentTextLabel.text = comment.text
                }
            }
        }
    }
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
