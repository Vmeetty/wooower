//
//  CustomTabBarController.swift
//  Wooower
//
//  Created by vlad on 01.08.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
//        tabBar.barTintColor = UIColor.black
//        tabBar.tintColor = UIColor.white
//        tabBar.layer.borderWidth = 1
//        let topBorder = CALayer()
//        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 3)
//        topBorder.backgroundColor = UIColor(red: 229, green: 231, blue: 235, alpha: 1).cgColor
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = getImageWithColor(color: UIColor.gray, size: CGSize(width: 1.0, height: 0.1))
    }
    

    func getImageWithColor(color: UIColor, size: CGSize) -> UIImage
    {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size.width, height: size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
}
