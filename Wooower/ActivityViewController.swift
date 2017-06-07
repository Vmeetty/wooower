//
//  ActivityViewController.swift
//  Wooower
//
//  Created by vlad on 06.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ActivityViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!


    var activityItem: PFObject? {
        didSet {
            configView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView () {
        if let activity = activityItem {
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
        }
    }

    
    

}
