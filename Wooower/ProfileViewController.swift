//
//  ProfileViewController.swift
//  Wooower
//
//  Created by vlad on 12.07.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var eventsCountLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
 
    var profile: Profile? {
        didSet {
            configProfile()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func configProfile () {
        commentsCountLabel.text = profile?.commentsCount
        userPhotoImageView.image = profile?.userPhoto
        userName.text = profile?.userName
        photoView.layer.cornerRadius = 50
        photoView.clipsToBounds = true
    }

}
