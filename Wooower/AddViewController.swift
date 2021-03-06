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
import MapKit

class AddViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var photoPanalConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageBox: PFImageView!
    var file: PFFile?
    var latitude: Double = 0
    var longitude: Double = 0
    var coreLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextView.textColor = UIColor.lightGray
        descriptionTextView.delegate = self
        descriptionTextView.text = "Write here..."
        observKeybordView()
        // optimize locationManager configuration
//        LocationDefining.sharedInstance.configLocationManager(sender: self)
        coreLocationManager.delegate = self
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if PFUser.current() == nil {
            LogInAndAddToData.sharedInstance.configActionSheet(sender: self)
        }
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        let post = PFObject(className: postParse)
        post[postDescription] = descriptionTextView.text
        post[postUser] = PFUser.current()
        post[postLatitude] = latitude
        post[postLongitude] = longitude
        if let file = file {
            post[postPicture] = file
        }
        post.saveEventually { (succes, error) in
            if succes {
                self.tabBarController?.selectedIndex = 0
                self.descriptionTextView.text = "Write here..."
                self.descriptionTextView.textColor = UIColor.lightGray
                self.imageBox.image = nil
            }
        }
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        tabBarController?.selectedIndex = 0
        descriptionTextView.text = "Write here..."
        descriptionTextView.textColor = UIColor.lightGray
        imageBox.image = nil  
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

extension AddViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        latitude = Double(location.coordinate.latitude)
        longitude = Double(location.coordinate.longitude)
    }
    
}

extension AddViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}











