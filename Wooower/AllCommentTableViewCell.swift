//
//  AllCommentTableViewCell.swift
//  Wooower
//
//  Created by vlad on 13.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

class AllCommentTableViewCell: UITableViewCell {

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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
