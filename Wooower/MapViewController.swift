//
//  MapViewController.swift
//  Wooower
//
//  Created by vlad on 05.07.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import MapKit
import Parse

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var coreLocationManager = CLLocationManager()
    var location: CLLocation?
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            if let location = location {
                MapManaging.sharedInstance.setRegionOnMap(sender: self, location: location)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coreLocationManager.delegate = self
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()
        FetchingPosts.sharedInstance.fetchPosts { (objects, posts, flag, error) in
            if flag {
                if let objects = objects {
                    MapManaging.sharedInstance.addPinsOnMap(sender: self, objects: objects)
                }
            } else {
                Spinners.sharedInstance.setCapView(sender: self, complition: { (labelText, view) in
                    labelText.text = "Uh Oh! There are no events still :("
                    view.addSubview(labelText)
                    self.mapView.addSubview(view)
                })
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coreLocationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
        mapView.showsUserLocation = true
    }
    
}
