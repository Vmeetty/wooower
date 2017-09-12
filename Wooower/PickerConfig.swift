//
//  ImagePickerConfig.swift
//  Wooower
//
//  Created by vlad on 05.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit

class PickerConfig {
    
    static func imagePickerConfig (viewController: AddViewController) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = viewController
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose the source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Casmera", style: .default, handler: { _ in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                viewController.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera is not available")
            }
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo library", style: .default, handler: { _ in
            imagePickerController.sourceType = .photoLibrary
            viewController.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(actionSheet, animated: true, completion: nil)
    }
    
}
