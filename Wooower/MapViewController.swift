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
    @IBOutlet weak var mapView: MKMapView!
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        coreLocationManager.delegate = self
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()
        if let location = location {
            MapManaging.sharedInstance.setRegionOnMap(sender: self, location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
        mapView.showsUserLocation = true
    }
    
}
