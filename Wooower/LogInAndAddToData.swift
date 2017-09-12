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
    
    func configActionSheet (sender: UIViewController) {
        let actionSheet = UIAlertController(title: alertTitle, message: alertMassage, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: { (action) in
            LogInAndAddToData.sharedInstance.showLoginForm(sender: sender)
        }))
        actionSheet.addAction(UIAlertAction(title: cancelAction, style: .cancel, handler: { (cancelAction) in
            if sender is AddViewController {
                sender.tabBarController?.selectedIndex = 0
            }
        }))
        sender.present(actionSheet, animated: true, completion: nil)
    }

    func showLoginForm(sender: UIViewController) {
        getFbData(sender: sender)
    }
    
    func getFbData(sender: UIViewController) {
        let manager = FBSDKLoginManager()
        manager.logIn(withReadPermissions: ["public_profile", "user_friends", "email"], from: sender) { (result, error) in
            let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large)"], httpMethod: "GET")
            request?.start(completionHandler: { (connection, result, error) in
                if ((error) != nil){
                    // Process error
                    print("Error: \(error)")
                }else if let fbUserData = result as? Dictionary<String, Any> {
                    self.configPFUser(fbUserData: fbUserData)
                }
            })
        }
    }
    
    func configPFUser (fbUserData: Dictionary<String, Any>) {
        if let picture = fbUserData["picture"] as? Dictionary<String, Any> {
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
                            let pfUser = PFUser()
                            let fbName : NSString = fbUserData["name"] as! NSString
                            pfUser.password = fbName as String
                            pfUser["fbName"] = fbName
                            let id = fbUserData["id"] as! String
                            pfUser["fbID"] = id
                            pfUser["username"] = id
                            pfUser["fbPhoto"] = self.file
                            
                            self.loginUser(userName: id as String, pass: fbName as String)
                            // проверка на наличие юзера в базе
                            let query = PFUser.query()
                            query?.whereKey(userFbID, equalTo: id)
                            query?.findObjectsInBackground(block: { (users, error) in
                                if let users = users {
                                    if users.count == 0 {
                                        self.signUpUser(pfUser: pfUser)
                                    } else {
                                       self.loginUser(userName: id as String, pass: fbName as String)
                                    }
                                }
                            })
                        })
                    }
                }
            }
        }
    }
    
    func signUpUser (pfUser: PFUser) {
        pfUser.signUpInBackground(block: { (succes, error) in
            if succes {
                print("sined up")
            } else {
                print("you have error")
            }
        })
    }
    
    func loginUser (userName: String, pass: String) {
        PFUser.logInWithUsername(inBackground: userName, password: pass) { (pfUser, error) in
            if pfUser != nil {
                print("it's loged in")
            } else if error != nil {
                print("smth wrong")
                print("Error: \(error!) \(error.debugDescription)")
            }
        }
    }
        
}

