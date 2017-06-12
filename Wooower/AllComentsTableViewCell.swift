//
//  AllComentsTableViewCell.swift
//  Wooower
//
//  Created by vlad on 12.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

class AllComentsTableViewCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var textCommentLabel: UILabel!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!

    var comment: Comment? {
        didSet {
           configCell()
        }
    }
    
    func configCell () {
        <#function body#>
    }

}
