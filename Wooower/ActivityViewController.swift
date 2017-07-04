//
//  ActivityViewController.swift
//  Wooower
//
//  Created by vlad on 06.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse

let commentCellID = "commentCell"
let allCommentsSegue = "AllCommentsViewController"

class ActivityViewController: UIViewController {

    var activityItem: PFObject? {
        didSet {
            configView ()
        }
    }
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet var myCommentTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var avatarView: UIView!    
    @IBOutlet weak var buttomCommentViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    
    var comments: [Comment]? = [] {
        didSet {
            myCommentTableView.reloadData()
            myCommentTableView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        scrollView.keyboardDismissMode = .onDrag
        gestureRecognize()
        observKeybordView()
        myCommentTableView.isHidden = true
    }
    
    func gestureRecognize () {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(gestureHendler))
        view.addGestureRecognizer(recognizer)
    }
    
    func gestureHendler () {
        view.endEditing(true)
    }
    
    func configView () {
        
        ConfigActivityView.sharedInstance.configView(activity: activityItem, activityVC: self)
        ConfigCommentView.sharedInstance.configComments(activity: activityItem,
                                                         runQueue: DispatchQueue.global(qos: .userInitiated),
                                                         complitionQueue: DispatchQueue.main) { (commentsArray, error) in
                                                            if let comments = commentsArray {
                                                                self.comments = comments
                                                            }
        }
        
    }
    
    func observKeybordView () {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(upperHandlerObserver(_:)), name: .UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(downHandlerObserver(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func upperHandlerObserver (_ notification: Notification) {
        buttomCommentViewConstraint.constant = getHeigthOfKeyboard(notification)
    }
    @objc func downHandlerObserver (_ notification: Notification) {
        buttomCommentViewConstraint.constant -= getHeigthOfKeyboard(notification)
    }
    
    func getHeigthOfKeyboard (_ notification: Notification) -> CGFloat {
        var keyboardHeigth: CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeigth = keyboardSize.height
        }
        return keyboardHeigth
    }
    
    
    @IBAction func allCommentsAction(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == allCommentsSegue {
            if let allCommentsVC = segue.destination as? AllCommentsViewController {
                if let currentPost = activityItem {
                    allCommentsVC.activityItem = currentPost
                }
            }
        }
    }
    
    @IBAction func sendCommentAction(_ sender: UIButton) {
        view.endEditing(true)
        let comment = PFObject(className: "Comment")
        comment["text"] = commentText.text
        comment["user"] = PFUser.current()
        comment["post"] = self.activityItem
        comment.saveInBackground { (succes, error) in
            let relation = self.activityItem?.relation(forKey: "comments")
            relation?.add(comment)
            self.activityItem?.saveInBackground(block: { (succes, error) in
                self.myCommentTableView.reloadData()
            })
        }
    }
    
}

extension ActivityViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let comments = comments {
            if comments.count > 3 {
                return 3
            } else {
                return comments.count
            }
        }
        return comments!.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: commentCellID, for: indexPath) as! CommentsTableViewCell
        if let comments = self.comments {
            cell.comment = comments[indexPath.row]
        }
        return cell
    }
    
}
















