//
//  ActivityTableViewController.swift
//  Wooower
//
//  Created by vlad on 08.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse

class ActivityTableViewController: UITableViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    @IBOutlet weak var avatarView: UIView!

    var activityItem: PFObject? {
        didSet {
            configTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
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
            }
            
            if let avatarView = avatarView {
                avatarView.layer.cornerRadius = 50
                avatarView.layer.borderWidth = 3
                avatarView.layer.borderColor = UIColor.white.cgColor
            }
            
        }
    }

   
}
