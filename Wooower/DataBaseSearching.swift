//
//  DataBaseSearching.swift
//  Wooower
//
//  Created by vlad on 26.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import Parse

class DataBaseSearching {
    
    static let sharedInstance = DataBaseSearching()
    private init() {}
    
    func chekcSameUsers (fbName: String) -> String {
        var sameUserEmail: String?
        var userName = ""
        let query = PFQuery(className: "User")
        query.whereKey("username", equalTo: fbName)
        query.findObjectsInBackground { (objects, error) in
            if let objects = objects {
                objects.forEach({ (object) in
                    if let name = object["username"] as? String {
                            userName = name
                    }
                })
            }
            if sameUserEmail == nil {
                userName = fbName
                // add user to dataBase
                EditDataBase.sharedInstance.addToData(fbName: fbName)
            }
        }
        return userName
    }

    
    func chekcSameUsers2 (fbID: String, fbName: String) -> String {
        var sameUserID: String?
        var userName = ""
        let query = PFQuery(className: "Pfuser")
        query.whereKey("fbID", equalTo: fbID)
        query.findObjectsInBackground { (objects, error) in
                if let objects = objects {
                    objects.forEach({ (object) in
                        if let id = object["fbID"] as? String, let name = object["name"] as? String {
                            if id == fbID {
                                sameUserID = id
                                userName = name
                            }
                        }
                    })
                }
                if sameUserID == nil {
                    userName = fbName
                    // add user to dataBase
                    EditDataBase.sharedInstance.addToData2(fbID: fbID, fbName: fbName)
                }
        }
        return userName
    }
    
}
