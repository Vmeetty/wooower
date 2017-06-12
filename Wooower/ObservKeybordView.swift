//
//  ObservKeybordView.swift
//  Wooower
//
//  Created by vlad on 05.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit

class ObservKeybordView {
    
    static let sharedInstance = ObservKeybordView()
    private init () {}
    
    func observKeybordView (observer: Any) {
        let center = NotificationCenter.default
        center.addObserver(observer, selector: #selector(handlerObserver(_:observer:)), name: .UIKeyboardWillShow, object: nil)
    }
    @objc func handlerObserver (_ notification: Notification, observer: Any) {
        if let activityVC = observer as? ActivityViewController {
            activityVC.buttomCommentViewConstraint.constant = KeyboardSize.getHeigthOfKeyboard(notification)
        }
    }
}
