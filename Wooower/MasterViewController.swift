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

class MasterViewController: UIViewController, PFLogInViewControllerDelegate {
    
    
    
    @IBOutlet weak var enterFB: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    var post: [Post] = []
    var objects: [PFObject] = []
    
    var userPhoto: UIImage?
    var fbName: String?
    var commentsCount: String = "0"
    
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
        Spinners.sharedInstance.setLoadingScreen(sender: self)
        FetchingPosts.sharedInstance.fetchPosts { (objectsArray, postsArray, flag, error) in
            if flag {
                if let objects = objectsArray, let posts = postsArray {
                    self.objects = objects
                    self.post = posts
                    self.myTableView.reloadData()
                    Spinners.sharedInstance.removeLoadingScreen()
                    Spinners.sharedInstance.removeCapView()
                }
            } else {
                Spinners.sharedInstance.removeLoadingScreen()
                Spinners.sharedInstance.setCapView(sender: self, complition: { (labelText, view) in
                    labelText.text = "Uh Oh! There are no events still :("
                    view.addSubview(labelText)
                    self.myTableView.addSubview(view)
                })
            }
            
        }
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
        } else if segue.identifier == profileSegueID {
            if let profileVC = segue.destination as? ProfileViewController {
                CurrentUserConfig.sharedInstance.fetchUser(pfUser: PFUser.current(), complition: { (dict) in
                    if dict != nil {
                        if let dict = dict {
                            if let name = dict[userFbName] as? String {
                                self.fbName = name
                            }
                            if let photo = dict[userFbPhoto] as? UIImage {
                                self.userPhoto = photo
                            } else {
                                self.userPhoto = UIImage(named: "123")
                            }
                            if let comments = dict[allUserComments] as? Array<Any> {
                                self.commentsCount = String(comments.count)
                            }
                            if let userName = self.fbName, let userPhoto = self.userPhoto {
                                let profile = Profile(userName: userName, userPhoto: userPhoto, commentsCount: self.commentsCount)
                                profileVC.profile = profile
                            }
                        }
                    }
                })
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

extension MasterViewController: UITableViewDataSource {
    
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

extension MasterViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if PFUser.current() == nil {
            let alert = UIAlertController(title: "Log in for this", message: "To create activity you should be sign up", preferredStyle: .alert)
            let action = UIAlertAction(title: "Sign in", style: .default, handler: { (action) in
                self.showLoginFormAction(UIBarButtonItem())
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
}




























