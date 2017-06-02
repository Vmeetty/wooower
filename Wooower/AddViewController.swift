//
//  AddViewController.swift
//  Wooower
//
//  Created by vlad on 02.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse

class AddViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func createAction(_ sender: UIBarButtonItem) {
        let post = PFObject(className: "Post")
        post["descriptions"] = descriptionTextView.text
        post["user"] = PFUser.current()
        post.saveEventually()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
