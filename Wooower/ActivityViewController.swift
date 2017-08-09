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
    
    var activityItem: PFObject? {
        didSet {
            configView ()
        }
    }
    @IBOutlet weak var commentText: UITextView!
    @IBOutlet var myCommentTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var avatarView: UIView!
    @IBOutlet weak var userPhotoConteinerView: UIView!
    @IBOutlet weak var userPhotoImageView: UIImageView!
    @IBOutlet weak var sendCommentViewConstraint: NSLayoutConstraint!
    var comments: [Comment]? = [] {
        didSet {
            myCommentTableView.reloadData()
            myCommentTableView.isHidden = false
        }
    }
    @IBOutlet weak var showAllCommentsButton: UIButton! {
        didSet {
            if oldValue == nil {
                self.showAllCommentsButton.layer.borderWidth = 0.3
                self.showAllCommentsButton.layer.borderColor = UIColor(red: 233/255, green: 235/255, blue: 238/255, alpha: 1.0).cgColor
                self.showAllCommentsButton.backgroundColor = UIColor(red: 246/255, green: 247/255, blue: 249/255, alpha: 1.0)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Spinners.sharedInstance.loadingView.isHidden = false
        Spinners.sharedInstance.setLoadingScreen(sender: self)
        configView()
        //        scrollView.keyboardDismissMode = .onDrag
        gestureRecognize()
        observKeybordView()
        myCommentTableView.isHidden = true
        myCommentTableView.rowHeight = UITableViewAutomaticDimension
        myCommentTableView.estimatedRowHeight = 140
        myCommentTableView.separatorStyle = .none
        myCommentTableView.tableFooterView = UIView()
    }
    
    func gestureRecognize () {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(gestureHendler))
        view.addGestureRecognizer(recognizer)
    }
    
    func gestureHendler () {
        view.endEditing(true)
    }
    
    func configView () {
        ConfigActivityView.sharedInstance.configView(activity: activityItem,
                                                     activityVC: self) { (createdAt, description, userName, userPhoto, activityPicture, flag) in
                                                        self.dateLabel.text = createdAt
                                                        self.descriptionLabel.text = description
                                                        self.nameLabel.text = userName
                                                        self.userPhotoImageView.image = userPhoto
                                                        self.pictureImageView.image = activityPicture
                                                        self.avatarView.layer.cornerRadius = 40
                                                        self.userPhotoConteinerView.layer.cornerRadius = 43
                                                        self.avatarView.clipsToBounds = true
                                                        Spinners.sharedInstance.removeLoadingScreen()
        }
        
        ConfigCommentView.sharedInstance.configComments(object: activityItem,
                                                        runQueue: DispatchQueue.global(qos: .userInitiated),
                                                        complitionQueue: DispatchQueue.main) { (commentsArray, error) in
                                                            if let comments = commentsArray {
                                                                self.comments = comments
                                                                self.showAllCommentsButton.setTitle("Show all comments (\(comments.count))", for: .normal)
                                                            }
        }
    }
    
    func observKeybordView () {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(upperHandlerObserver(_:)), name: .UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(downHandlerObserver(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func upperHandlerObserver (_ notification: Notification) {
        sendCommentViewConstraint.constant -= getHeigthOfKeyboard(notification)
    }
    @objc func downHandlerObserver (_ notification: Notification) {
        sendCommentViewConstraint.constant = 0
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
        let comment = PFObject(className: commentParse)
        comment[commentTxt] = commentText.text
        comment[commentUser] = PFUser.current()
        comment[commentPost] = self.activityItem
        comment.saveInBackground { (succes, error) in
            let postCommentRelation = self.activityItem?.relation(forKey: postComments)
            postCommentRelation?.add(comment)
            if let user = self.activityItem?[postUser] as? PFUser {
                let userCommentRelation = user.relation(forKey: userComments)
                userCommentRelation.add(comment)
            }
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
















