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
    var comments: [Comment]?
    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    func configView () {
        ConfigCommentView.sharedInstance.configComments3(activity: activityItem,
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
        var numberOfRows = 0
        if let comments = comments {
            numberOfRows = comments.count
        }
        return numberOfRows
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: allCommentCellID, for: indexPath) as! AllCommentTableViewCell
        if let comments = self.comments {
            cell.comment = comments[indexPath.row]
        }
        return cell
    }
    
}





























