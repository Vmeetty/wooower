//
//  ActivityTableViewController.swift
//  Wooower
//
//  Created by vlad on 08.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ActivityTableViewController: UITableViewController {

    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var avatarView: UIView!
    
    // comments items
    
    @IBOutlet weak var firstCommentAvatarView: UIView!
    @IBOutlet weak var firstCommentAvatarImageView: UIImageView!
    @IBOutlet weak var firstCommentNameLabel: UILabel!
    @IBOutlet weak var firstCommentDescriptionLabel: UILabel!
    @IBOutlet weak var secondCommentAvatarView: UIView!
    @IBOutlet weak var secondCommentAvatarImageView: UIImageView!
    @IBOutlet weak var secondCommentNameLabel: UILabel!
    @IBOutlet weak var secondCommentDescriptionLabel: UILabel!
    @IBOutlet weak var thirdCommentAvatarView: UIView!
    @IBOutlet weak var thirdCommentAvatarImageView: UIImageView!
    @IBOutlet weak var thirdCommentNameLabel: UILabel!    
    @IBOutlet weak var thirdCommentDescriptionLabel: UILabel!
    
    
    

    var activityItem: PFObject? {
        didSet {
            configTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        myTableView.keyboardDismissMode = .onDrag
    }

    func configTableView () {
        if let activity = activityItem {
            if let createdDate = activity.createdAt {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM"
                let useDate = dateFormatter.string(from: createdDate)
                if let dateStr = dateLabel {
                    dateStr.text = "posted " + useDate
                }
            }
            if let descriptionLabel = descriptionLabel {
                descriptionLabel.text = (activity["descriptions"] as! String)
                if let user = activity["user"] as? PFUser {
                    if let userName = user.username {
                        nameLabel.text = userName
                    }
                }
                if let imageFile = activity["picture"] as? PFFile {
                    imageFile.getDataInBackground(block: { (data, error) in
                        if let imageData = UIImage(data: data!) {
                            self.pictureImageView.image = imageData
                        }
                        
                    })
                }
                let commentRelation = activityItem?.relation(forKey: "comments")
                let query = commentRelation?.query()
                query?.includeKey("user")
                query?.findObjectsInBackground(block: { (comments, error) in
                    if let comments = comments {
                        var nickNameStr = ""
                        var textStr = ""
                        comments.forEach({ (object) in
                            if let username = (object["user"] as? PFUser)?.username {
                                nickNameStr = username
                            }
                            let text = object["text"] as! String
                            textStr = text
                        })
                        self.firstCommentNameLabel.text = nickNameStr
                        self.firstCommentDescriptionLabel.text = textStr
                    }
                })
            }
            
            if let avatarView = avatarView {
                avatarView.layer.cornerRadius = 50
                avatarView.layer.borderWidth = 3
                avatarView.layer.borderColor = UIColor.white.cgColor
            }
            
        }
    }

    @IBAction func allCommentsAction(_ sender: UIButton) {
    }
    
   
}
