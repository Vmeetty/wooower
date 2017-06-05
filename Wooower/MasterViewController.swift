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

let cellID = "wooowerCell"

class MasterViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var post: [Post] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        fetchPosts()
        self.myTableView.reloadData()
    }
    
    @IBAction func showLoginFormAction(_ sender: UIBarButtonItem) {
        let login = PFLogInViewController()
        present(login, animated: true) {
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
                self.post = objects.map({ (post) -> Post in
                    // fetch user for post
                    var userName = ""
                    if let user = post["user"] as? PFUser {
                        // ** Использовать fetchIfNeededInBackground()
                        do {
                            let u = try user.fetchIfNeeded()
                            if let username = u.username {
                                userName = username
                            }
                        }catch {
                            print("There was no data about user.username. *Vlad")
                        }
                    }
                    let post = Post(name: userName, description: post["descriptions"] as! String)
                    return post
                })
                self.myTableView.reloadData()
            }
        }
    }

    
}

