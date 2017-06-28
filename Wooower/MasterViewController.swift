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
        fetchPosts()
        self.myTableView.reloadData()
    }
    
    @IBAction func showLoginFormAction(_ sender: UIBarButtonItem) {
        if PFUser.current() == nil {
            FetchingFBData.sharedInstance.loginUser2(sender: self)
//            let loginViewController = PFLogInViewController()
//            loginViewController.fields = .facebook
//            loginViewController.facebookPermissions = ["public_profile"]
//            loginViewController.delegate = self
//            self.present(loginViewController, animated: true, completion: nil)
            
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
    
    func fetchPosts () {
        let query = PFQuery(className: "Post")
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                self.objects = objects
                self.post = objects.map({ (post) -> Post in
                    // fetch user for post
                    var name = ""
                    if let user = post["user"] as? PFUser {
                        // ** Использовать fetchIfNeededInBackground()
//                        user.fetchIfNeededInBackground(block: { (object, error) in
//                            if let user = object as? PFUser {
//                                if let userName = user.username {
//                                    name = userName
//                                }
//                            }
//                        })
                        do {
                            let u = try user.fetchIfNeeded()
                            if let username = u.username {
                                name = username
                            }
                        }catch {
                            print("There was no data about user.username. *Vlad")
                        }
                    }
                    let post = Post(name: name, description: post["descriptions"] as! String)
                    return post
                })
                self.myTableView.reloadData()
            }
        }
    }
}

























