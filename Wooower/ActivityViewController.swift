//
//  ActivityViewController.swift
//  Wooower
//
//  Created by vlad on 06.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ActivityViewController: UIViewController {

    var activityItem: PFObject?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ActivityTableViewController" {
            if let activityTable = segue.destination as? ActivityTableViewController {
                activityTable.activityItem = self.activityItem
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

















