//
//  AddViewController.swift
//  Wooower
//
//  Created by vlad on 02.06.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse
import ParseUI

let addCellID = "addCell"

class AddViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var photoPanalConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageBox: PFImageView!
    var file: PFFile?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.becomeFirstResponder()
        observKeybordView()
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        let post = PFObject(className: "Post")
        post["descriptions"] = descriptionTextView.text
        post["user"] = PFUser.current()
        if let file = file {
            post["picture"] = file
        }
        post.saveEventually()
        self.dismiss(animated: true, completion: nil)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func addPhotoAction(_ sender: UIButton) {
        PickerConfig.imagePickerConfig(viewController: self)
    }
    
    func observKeybordView () {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(panalUp(_:)), name: .UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(panalDown(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    func panalUp (_ notification: Notification) {
        photoPanalConstraint.constant = KeyboardSize.getHeigthOfKeyboard(notification)
    }
    func panalDown (_ notification: Notification) {
        photoPanalConstraint.constant -= KeyboardSize.getHeigthOfKeyboard(notification)
    }
    func getHeigthOfKeyboard (_ notification: Notification) -> CGFloat {
        var keyboardHeigth: CGFloat = 0
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeigth = keyboardSize.height
        }
        return keyboardHeigth
    }
}

extension AddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data = UIImageJPEGRepresentation(image, 0.3)
        if let data = data {
            let parseFile = PFFile(data: data, contentType: "jpg")
            self.file = parseFile
            imageBox.image = UIImage(data: data)
            parseFile.saveInBackground(block: { (success, error) in
                print(success ? "success" : "error")
            })
            
        }
        picker.dismiss(animated: true, completion: nil)
        
        descriptionTextView.becomeFirstResponder()
    }
}














