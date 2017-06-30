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

class LogInAndAddToData {
    
    static let sharedInstance = LogInAndAddToData()
    private init() {}
    
    func loginUser3 (sender: Any) {
        PFFacebookUtils.logInInBackground(withReadPermissions: ["public_profile", "user_friends", "email"], block: { (result, error) in
            if let user = result {
                if user.isNew {
                    print("User signed up and logged in through Facebook!")
                } else {
                    print("User logged in through Facebook!")
                }
//                self.fetchingFbData3(pfUser: user)
            } else {
                print("Uh oh. The user cancelled the Facebook login.")
            }
        })
    }
    
    func fetchingFbData3 (pfUser: PFUser, sender: Any) {
        let manager = FBSDKLoginManager()
        if let sender = sender as? MasterViewController {
            manager.logIn(withReadPermissions: [], from: sender) { (result, error) in
                let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture"], httpMethod: "GET")
                request?.start(completionHandler: { (connection, result, error) in
                    if ((error) != nil){
                        // Process error
                        print("Error: \(error)")
                    }else if let result = result as? Dictionary<String, Any> {
                        print("fetched user: \(result)")
                        let userName : NSString = result["name"] as! NSString
                        print("User Name is: \(userName)")
                        pfUser["username"] = userName
                        pfUser.password = userName as String
                        pfUser["fbName"] = userName
                        let id : NSString = result["id"] as! NSString
                        print("User id is: \(id)")
                        pfUser.signUpInBackground(block: { (succes, error) in
                            print("user saved")
                        })
                    }
                })
            }
        }
        
        
    }
    
    
    
    
    
    
    //    let loginViewController = PFLogInViewController()
    //        loginViewController.fields = [.facebook]
    //        loginViewController.facebookPermissions = ["public_profile"]
    //        loginViewController.delegate = sender
    //        self.present(loginViewController, animated: true, completion: nil)
    
    
    
    
    
    ////////////////////////
    
    func loginUser2 (sender: Any) {
        PFFacebookUtils.logInInBackground(withReadPermissions: ["public_profile"], block: { (result, error) in
            if let user = result {
                
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
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, email, name, picture.type(large)"], httpMethod: "GET")
        request?.start(completionHandler: { (_, result, _) in
            if let result = result as? Dictionary<String, Any> {
                let name = result["name"] as! String
//                let email = result["email"] as! String
                let userName = DataBaseSearching.sharedInstance.chekcSameUsers(fbName: name)
                if let sender = sender as? MasterViewController {
                    sender.enterFB.title = userName
                }
            }
        })
        
    }
    
}

