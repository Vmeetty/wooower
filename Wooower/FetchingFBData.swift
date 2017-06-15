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

class FetchingFBData {
    
    static let sharedInstance = FetchingFBData()
    private init() {}
    
    func loginUser (sender: Any) {
        let manager = FBSDKLoginManager()
        if let sender = sender as? MasterViewController {
            manager.logIn(withReadPermissions: [], from: sender) { (result, error) in
                self.fetchingFbData()
            }
        }
        
    }
    
    func fetchingFbData () {
        let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large)"], httpMethod: "GET")
        request?.start { (_, result, error) in
            if let result = result as? Dictionary<String, Any> {
                let name = result["name"] as! String
                if let picture = result["picture"] as? Dictionary<String, Any> {
                    if let data = picture["data"] as? Dictionary<String, Any> {
                        let imgUrl = data["url"] as! String
                    }
                }
            }
        }
    }
    
}
