//
//  AddToDataBase.swift
//  Wooower
//
//  Created by vlad on 26.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import Parse

class EditDataBase {

    static let sharedInstance = EditDataBase()
    private init() {}
    
    func addToData (fbName: String) {
        let pfUser = PFUser()
        pfUser["username"] = fbName
        pfUser.saveEventually()
    }
    
    func addToData2 (fbID: String, fbName: String) {
        let fbUser = PFObject(className: "Fbuser")
        fbUser["name"] = fbName
        fbUser["fbID"] = fbID
        fbUser.saveEventually()
    }

}
