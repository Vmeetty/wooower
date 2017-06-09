//
//  ActivityViewController.swift
//  Wooower
//
//  Created by vlad on 06.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse


class ActivityViewController: UIViewController {

    var activityItem: PFObject?    
    @IBOutlet weak var commentText: UITextView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ActivityTableViewController" {
            if let activityTable = segue.destination as? ActivityTableViewController {
                activityTable.activityItem = self.activityItem
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func sendCommentAction(_ sender: UIButton) {
        let comment = PFObject(className: "Comment")
        comment["text"] = commentText.text
        comment["user"] = PFUser.current()
        comment["post"] = self.activityItem
        comment.saveInBackground { (succes, error) in
            let relation = self.activityItem?.relation(forKey: "comments")
            relation?.add(comment)
            self.activityItem?.saveInBackground(block: { (succes, error) in
                print("upload \(succes)")
            })
        }
    }

}

















