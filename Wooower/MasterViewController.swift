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
    var postDescription: [String] = []
//    var post: [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
//        postDescription = Fetching.fetchPosts()
//        myTableView.reloadData()
        fetchPosts()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension MasterViewController: UITableViewDataSource, UITabBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDescription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? TableViewCell
        let object = postDescription[indexPath.row]
        cell?.descriptionTextView.text = object
        
        return cell!
    }
    
}

extension MasterViewController {
    
    func fetchPosts () {
        let query = PFQuery(className: "Post")
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                self.postDescription = objects.map({ (post) -> String in
                    return post["descriptions"] as? String ?? "Ups"
                })
                self.myTableView.reloadData()
            }
        }
    }

    
}

