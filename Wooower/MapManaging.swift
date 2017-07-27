//
//  MapManaging.swift
//  Wooower
//
//  Created by vlad on 21.07.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import Parse
import MapKit

class MapManaging: NSObject, CLLocationManagerDelegate {
    var coreLocationManager = CLLocationManager()
    var location: CLLocation?
    static let sharedInstance = MapManaging()
    private override init () {}
    
    func addPinsOnMap (sender: MapViewController, objects: [PFObject]) {
        var annotations: [MKPointAnnotation] = []
        for object in objects {
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
        sender.mapView.addAnnotations(annotations)
    }
    
    func setRegionOnMap (sender: MapViewController, location: CLLocation) {
        let span = MKCoordinateSpanMake(10, 10)
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: myLocation, span: span)
        sender.mapView.setRegion(region, animated: true)
    }
}
