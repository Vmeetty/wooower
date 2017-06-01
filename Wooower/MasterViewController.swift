//
//  ViewController.swift
//  Wooower
//
//  Created by vlad on 31.05.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse

let cellID = "wooowerCell"

class MasterViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    var post: [Post] = []
//    var post: [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addToPost()
    }
    
    func addToPost () {
        post.append(Post(firstName: "Semen", lastName: "Lololl", avatarImage: UIImage(named: "user")!, description: "dsadasdasd"))
        }
    
    override func viewWillAppear(_ animated: Bool) {
//        fetchPosts()
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
        let object = post[indexPath.row]
        cell?.post = object
        
        return cell!
    }
    
}

//extension MasterViewController {
//    
//    func fetchPosts () {
//        let query = PFQuery(className: "Post")
//        query.findObjectsInBackground { (objects, error) in
//            if let objects = objects {
//                self.post = objects
//                self.myTableView.reloadData()
//            }
//        }
//    }
//
//    
//}

