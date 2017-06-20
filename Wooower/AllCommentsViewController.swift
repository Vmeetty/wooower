//
//  AllCommentsViewController.swift
//  Wooower
//
//  Created by vlad on 13.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse

let allCommentCellID = "allCommentCellID"

class AllCommentsViewController: UIViewController {

    var activityItem: PFObject? {
        didSet {
            configView ()
        }
    }
    var comments: [Comment] = []
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView () {
//        ConfigCommentView.sharedInstance.configComments(activity: activityItem, sender: self)
        ConfigCommentView.sharedInstance.configComments2(activity: activityItem,
                                                         runQueue: DispatchQueue.global(qos: .userInitiated),
                                                         complitionQueue: DispatchQueue.main) { (comment, error) in
                                                            if let comment = comment {
                                                                self.comments.append(comment)
                                                            }
                                                            
        }
    }


}

extension AllCommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: allCommentCellID, for: indexPath) as! AllCommentTableViewCell
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            cell.comment = self.comments[indexPath.row]
        }
        return cell
    }
    
}





























