//
//  FetchingFBData.swift
//  Wooower
//
//  Created by vlad on 15.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import FBSDKCoreKit
import ParseFacebookUtilsV4

class FetchingFBData {
    
    static let sharedInstance = FetchingFBData()
    private init() {}
    
    func loginUser2 (sender: Any) {
        PFFacebookUtils.logInInBackground(withReadPermissions: ["public_profile"], block: { (result, error) in
            if let user = result {
                self.fetchingFbData2(pfUser: user)
            }
        })
    }
    
    func fetchingFbData2 (pfUser: PFUser) {
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large)"], httpMethod: "GET")
        request?.start(completionHandler: { (_, result, _) in
            if let result = result as? Dictionary<String, Any> {
                let userObject = pfUser as PFObject
                if let fbName = result["name"] as? String {
                    userObject["fbName"] = fbName
                }
//                pfUser.username = result["name"] as? String
//                let id = result["id"] as! String
//                let userName = DataBaseSearching.sharedInstance.chekcSameUsers(fbID: id, fbName: name)
//                if let sender = sender as? MasterViewController {
//                    sender.enterFB.title = userName
//                }
            }
        })
        
    }
    
    func loginUser (sender: Any) {
        let manager = FBSDKLoginManager()
        if let sender = sender as? MasterViewController {
            manager.logIn(withReadPermissions: [], from: sender) { (result, error) in
                self.fetchingFbData(sender: sender)
            }
        }
        
    }
    
    func fetchingFbData (sender: Any) {
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large)"], httpMethod: "GET")
        request?.start(completionHandler: { (_, result, _) in
            if let result = result as? Dictionary<String, Any> {
                let name = result["name"] as! String
                let id = result["id"] as! String
                let userName = DataBaseSearching.sharedInstance.chekcSameUsers(fbID: id, fbName: name)
                if let sender = sender as? MasterViewController {
                    sender.enterFB.title = userName
                }
            }
        })
        
    }
    
}
