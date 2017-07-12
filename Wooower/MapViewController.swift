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
    var location: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPinsOnMap()
        // optimize locationManager configuration
//        LocationDefining.sharedInstance.configLocationManager(sender: self)
        coreLocationManager.delegate = self
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()
        setRegionOnMap()
    }
    
    func setRegionOnMap () {
        let span = MKCoordinateSpanMake(10, 10)
        if let location = self.location {
           let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region = MKCoordinateRegion(center: myLocation, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func addPinsOnMap () {
        var annotations: [MKPointAnnotation] = []
        for object in postObjects {
            if let latitude = object[postLatitude] as? Double, let longitude = object[postLongitude] as? Double {
                let pinLocation = CLLocationCoordinate2DMake(latitude, longitude)
                let annotation = MKPointAnnotation()
                annotation.coordinate = pinLocation
                if let user = object[postUser] as? PFUser {
                    if let name = user[userName] as? String {
                        annotation.title = name
                    }
                }
                if let description = object[postDescription] as? String {
                    annotation.subtitle = description
                }
                annotations.append(annotation)
            }
        }
        mapView.addAnnotations(annotations)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
        mapView.showsUserLocation = true
    }


}
