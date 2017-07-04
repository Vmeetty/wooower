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
    
    var file: PFFile?
    
    func fetchingFbData3 (pfUser: PFUser, sender: Any) {
        let manager = FBSDKLoginManager()
        if let sender = sender as? MasterViewController {
            manager.logIn(withReadPermissions: ["public_profile", "user_friends", "email"], from: sender) { (result, error) in
                let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large)", "user_friends": "id, name, picture"], httpMethod: "GET")
                request?.start(completionHandler: { (connection, result, error) in
                    if ((error) != nil){
                        // Process error
                        print("Error: \(error)")
                    }else if let result = result as? Dictionary<String, Any> {
                        self.configPFUser(pfUser: pfUser, response: result)
                    }
                })
            }
        }
        
        
    }
    
    func configPFUser (pfUser: PFUser, response: Dictionary<String, Any>) {
        print("fetched user: \(response)")
        // edit PFUser
        if let picture = response["picture"] as? Dictionary<String, Any> {
            if let data = picture["data"] as? Dictionary<String, Any> {
                let stringUrl = data["url"] as! String
                let data = try? Data(contentsOf: NSURL(string: stringUrl) as! URL)
                if let data = data {
                    let image = UIImage(data: data)
                    if let jpegData = UIImageJPEGRepresentation(image!, 0.3) {
                        let parseFile = PFFile(data: jpegData, contentType: "jpg")
                        self.file = parseFile
                        parseFile.saveInBackground(block: { (succes, error) in
                            print("upload " + (succes ? "succes" : "error"))
                            let userName : NSString = response["name"] as! NSString
                            pfUser["username"] = userName
                            pfUser.password = userName as String
                            pfUser["fbName"] = userName
                            let id : NSString = response["id"] as! NSString
                            pfUser["fbID"] = id
                            pfUser["fbPhoto"] = self.file
                            pfUser.signUpInBackground(block: { (succes, error) in
                                if succes {
                                    print("sined up")
                                } else {
                                    print("you have error")
                                }
                            })
                        })
                    }
                }
                
            }
        }
    }
    
    
    
    
    
    
    
    
    //    let loginViewController = PFLogInViewController()
    //        loginViewController.fields = [.facebook]
    //        loginViewController.facebookPermissions = ["public_profile"]
    //        loginViewController.delegate = sender
    //        self.present(loginViewController, animated: true, completion: nil)
    
    func loginUser3 () {
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

