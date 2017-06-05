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
    
    func observKeybordView (observer: Any) {
        let center = NotificationCenter.default
        center.addObserver(observer, selector: #selector(handlerObserver(_:)), name: .UIKeyboardWillShow, object: nil)
    }
    @objc func handlerObserver (_ notification: Notification) {
        
    }
}
