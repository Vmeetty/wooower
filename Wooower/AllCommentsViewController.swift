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
    @IBOutlet weak var myTableView: UITableView!
    var comments: [Comment]? = [] {
        didSet {
            myTableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView () {
        ConfigCommentView.sharedInstance.configComments(activity: activityItem,
                                                         runQueue: DispatchQueue.global(qos: .userInitiated),
                                                         complitionQueue: DispatchQueue.main) { (commentsArray, error) in
                                                            if let comments = commentsArray {
                                                                self.comments = comments
                                                            }
        }
    }


}

extension AllCommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: allCommentCellID, for: indexPath) as! AllCommentTableViewCell
        if let comments = self.comments {
            cell.comment = comments[indexPath.row]
        }
        return cell
    }
    
}





























