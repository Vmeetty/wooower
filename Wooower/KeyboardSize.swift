//
//  KeyboardSize.swift
//  Wooower
//
//  Created by vlad on 05.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit

class KeyboardSize {
    
    static func getHeigthOfKeyboard (_ notification: Notification) -> CGFloat {
        var keyboardHeigth: CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeigth = keyboardSize.height
        }
        return keyboardHeigth
    }
    
}
