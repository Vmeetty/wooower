//
//  AllCommentsViewController.swift
//  Wooower
//
//  Created by vlad on 12.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

let allCommentCellID = "allCommentCellID"

class AllCommentsViewController: UIViewController {

    var allComment: [Comment] = []

    override func viewDidLoad() {
        super.viewDidLoad()

//        ConfigCommentView.sharedInstance.configComments(activity: <#T##PFObject?#>, controller: <#T##Any?#>)
    }
    
    
}

extension AllCommentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allComment.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: allCommentCellID, for: indexPath) as! AllComentsTableViewCell
        cell.comment = allComment[indexPath.row]
        return cell
    }
    
}
