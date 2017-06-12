//
//  ConfigActivityView.swift
//  Wooower
//
//  Created by vlad on 09.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import Parse

class ConfigActivityView {
    
    static let sharedInstance = ConfigActivityView()
    private init () {}
    
    func configView (activity: PFObject?, activityVC: ActivityViewController) {
        if let activity = activity {
            if let createdDate = activity.createdAt {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MMMM"
                let useDate = dateFormatter.string(from: createdDate)
                if let dateStr = activityVC.dateLabel {
                    dateStr.text = "posted " + useDate
                }
            }
            if let descriptionLabel = activityVC.descriptionLabel {
                descriptionLabel.text = (activity["descriptions"] as! String)
                if let user = activity["user"] as? PFUser {
                    if let userName = user.username {
                        activityVC.nameLabel.text = userName
                    }
                }
                if let imageFile = activity["picture"] as? PFFile {
                    imageFile.getDataInBackground(block: { (data, error) in
                        if let imageData = UIImage(data: data!) {
                            activityVC.pictureImageView.image = imageData
                        }
                    })
                }
            }
        }
            ConfigCommentView.sharedInstance.configComments(activity: activity, controller: activityVC)
    }

    
}























