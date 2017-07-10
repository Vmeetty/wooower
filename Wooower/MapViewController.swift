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

    var postObjects:[PFObject] = []
    var coreLocationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPinsOnMap()
        // optimize locationManager configuration
//        LocationDefining.sharedInstance.configLocationManager(sender: self)
        coreLocationManager.delegate = self
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()
        
    }
    
    func addPinsOnMap () {
        var annotations: [MKPointAnnotation] = []
        for object in postObjects {
            if let latitude = object["latitude"] as? Double, let longitude = object["longitude"] as? Double {
                let pinLocation = CLLocationCoordinate2DMake(latitude, longitude)
                let annotation = MKPointAnnotation()
                annotation.coordinate = pinLocation
                if let user = object["user"] as? PFUser {
                    if let name = user["username"] as? String {
                        annotation.title = name
                    }
                }
                if let description = object["descriptions"] as? String {
                    annotation.subtitle = description
                }
                annotations.append(annotation)
            }
        }
        mapView.addAnnotations(annotations)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span = MKCoordinateSpanMake(10, 10)
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: myLocation, span: span)
//        mapView.setRegion(region, animated: true)
        
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
    }
    


}
