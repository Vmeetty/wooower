//
//  Spinners.swift
//  Wooower
//
//  Created by vlad on 17.07.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import Foundation
import UIKit

class Spinners {
    
    static let sharedInstance = Spinners()
    private init() {}
    
    /// View which contains the loading text and the spinner
    var loadingView = UIView()
    
    /// Spinner shown during load the TableView
    let spinner = UIActivityIndicatorView()
    
    /// Text shown during load the TableView
    var loadingLabel = UILabel()
    
    /// View which contains the cap
    let capView = UIView()
    /// Cap Text
    let capLabel = UILabel()
    
    func configLoadingView () {
        let loadingViewWidthBounds = loadingView.bounds.size.width
        let loadingViewHeigthBounds = loadingView.bounds.size.height
        
        // Sets loading text
        loadingLabel.textColor = UIColor.gray
        loadingLabel.text = "Loading..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 130, height: 30)
        
        // Sets spinner
        spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        
        // Put elemts in conteinerView
        let conteinerView = UIView()
        let conteinerWidth = loadingLabel.frame.width + spinner.frame.width
        let conteinerHeigth = loadingLabel.frame.height + spinner.frame.height
        conteinerView.frame = CGRect(x: 0, y: 0, width: conteinerWidth, height: conteinerHeigth)
        conteinerView.backgroundColor = UIColor.white
        conteinerView.center = CGPoint(x: loadingViewWidthBounds / 2, y: loadingViewHeigthBounds / 2)
        
        // Align loadingLabel and spinner
        let verticalSpinnerPosition = (conteinerView.frame.width - conteinerView.frame.width) + 35
        spinner.center = CGPoint(x: verticalSpinnerPosition, y: conteinerView.frame.height / 2)
        loadingLabel.center = CGPoint(x: verticalSpinnerPosition + (loadingLabel.frame.width / 2 - 10), y: conteinerView.frame.height / 2)
        
        // Adds text and spinner to the view
        conteinerView.addSubview(spinner)
        conteinerView.addSubview(loadingLabel)
        loadingView.addSubview(conteinerView)
    }
    
    func setLoadingScreen(sender: UIViewController) {
        
        // Sets the view which contains the loading text and the spinner
        if let masterVC = sender as? MasterViewController {
            let width: CGFloat = 120
            let height: CGFloat = 30
            let x = (masterVC.myTableView.frame.width / 2) - (width / 2)
            let y = (masterVC.myTableView.frame.height / 2) - (height / 2) - (masterVC.navigationController?.navigationBar.frame.height)!
            loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
            
            // Sets loading text
            loadingLabel.textColor = UIColor.gray
            loadingLabel.textAlignment = NSTextAlignment.center
            loadingLabel.text = "Loading..."
            loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
            
            // Sets spinner
            spinner.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
            spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            spinner.startAnimating()
            
            // Adds text and spinner to the view
            loadingView.addSubview(spinner)
            loadingView.addSubview(loadingLabel)
            
            masterVC.myTableView.addSubview(loadingView)
        }else {
            let width: CGFloat = sender.view.frame.width
            let height: CGFloat = sender.view.frame.height
            let x = (sender.view.frame.width / 2) - (width / 2)
            let y = (sender.view.frame.height / 2) - (height / 2) - (sender.navigationController?.navigationBar.frame.height)!
            loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
            loadingView.backgroundColor = UIColor.white
            
            // Config loadingView
            configLoadingView()
            sender.view.addSubview(loadingView)
        }
    }
    
    
    
    func setCapView(sender: UIViewController, complition: (_ label: UILabel, _ capView: UIView)->()) {
        // Sets the view which contains the loading text and the spinner
        
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (sender.view.frame.width / 2) - (width / 2)
        let y = (sender.view.frame.height / 2) - (height / 2) - (sender.navigationController?.navigationBar.frame.height)!
        capView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Sets loading text
        capLabel.textColor = UIColor.gray
        capLabel.textAlignment = NSTextAlignment.center
//        capLabel.text = "Uh Oh! There are no events still :("
        capLabel.lineBreakMode = .byWordWrapping
        capLabel.numberOfLines = 0
        capLabel.frame = CGRect(x: 0, y: -80, width: 140, height: 70)
        
        // Adds text and spinner to the view
        capView.addSubview(capLabel)
        complition(capLabel, capView)
        
        
    }
    
    
    // Remove the activity indicator from the main view
    func removeLoadingScreen() {
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        loadingView.isHidden = true
    }
    // Remove the cap from the main view
    func removeCapView() {
        // Hides and stops the text and the spinner
        capView.isHidden = true
    }
    
}
