//
//  ViewController.swift
//  Wooower
//
//  Created by vlad on 31.05.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import FBSDKLoginKit
import FBSDKCoreKit
import ParseFacebookUtilsV4

let cellID = "wooowerCell"
let activityViewController = "ActivityViewController"
let profileSegueID = "ProfileViewController"

class MasterViewController: UIViewController, PFLogInViewControllerDelegate {
    
    @IBOutlet weak var enterFB: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    var post: [Post] = []
    var objects: [PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    func displayProfileButton () {
        if PFUser.current() == nil {
            enterFB.title = "Enter"
        } else {
            let exitButton = UIBarButtonItem(title: "Exit", style: .plain, target: self, action: #selector(lofOut))
            navigationItem.leftBarButtonItem = exitButton
            enterFB.title = "Profile"
        }
    }
    
    func lofOut () {
        // logout code
        PFUser.logOut()
        enterFB.title = "Enter"
        navigationItem.leftBarButtonItem = nil
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayProfileButton()
        fetchPosts2()
    }
    
    @IBAction func showLoginFormAction(_ sender: UIBarButtonItem) {
        if PFUser.current() == nil {
            let pfUser = PFUser()
            LogInAndAddToData.sharedInstance.fetchingFbData3(pfUser: pfUser, sender: self)
        } else {
            performSegue(withIdentifier: profileSegueID, sender: self)
        }
        
    }
    
    @IBAction func createAction(_ sender: UIButton) {
        if PFUser.current() == nil {
            let alert = UIAlertController(title: "Log in for this", message: "To create activity you should be sign up", preferredStyle: .alert)
            let action = UIAlertAction(title: "Sign in", style: .default, handler: { (action) in
                self.showLoginFormAction(UIBarButtonItem())
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == activityViewController {
            if let activityVC = segue.destination as? ActivityViewController {
                if let indexPath = myTableView.indexPathForSelectedRow {
                    let object = objects[indexPath.row]
                    activityVC.activityItem = object
                }
            }
        }
    }
    
    func log(_ logInController: PFLogInViewController, didLogIn user: PFUser) {
        logInController.dismiss(animated: true) {
            self.myTableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension MasterViewController: UITableViewDataSource, UITabBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TableViewCell
        let post = self.post[indexPath.row]
        cell?.post = post
        
        return cell!
    }
    
}

extension MasterViewController {
    
    
    func fetchPosts2 () {
        let query = PFQuery(className: "Post")
        query.includeKey("user")
        query.order(byAscending: "createdAt")
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let objects = try query.findObjects()
                FetchingPosts.sharedInstance.fetchPosts(objects: objects, complitionQueue: DispatchQueue.main, complition: { (posts, objects, error) in
                    if let posts = posts, let objects = objects {
                        self.objects = objects
                        self.post = posts
                        self.myTableView.reloadData()
                    }
                })
            } catch let error {
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
    }
    
    
}

























