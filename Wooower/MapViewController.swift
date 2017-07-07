//
//  MapViewController.swift
//  Wooower
//
//  Created by vlad on 05.07.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var objectAdress: UILabel!
    
    var coreLocationManager = CLLocationManager()
    var locationManager: LocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coreLocationManager.delegate = self
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()
//        locationManager = LocationManager.sharedInstance
//        let authorizationCode = CLLocationManager.authorizationStatus()
        
//        if authorizationCode == CLAuthorizationStatus.notDetermined && coreLocationManager.responds(to:(Selector(("authorizationIfUsage")))) {
//            if Bundle.main.object(forInfoDictionaryKey: "Location When In Use Usage Description") != nil {
//                coreLocationManager.requestWhenInUseAuthorization()
//            }else {
//                print("no description provided")
//            }
//        }else {
//            getLocation()
//        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: myLocation, span: span)
        mapView.setRegion(region, animated: true)
        
        mapView.showsUserLocation = true
    }
    
//    func getLocation () {
//        locationManager.startUpdatingLocationWithCompletionHandler { (latitude, longitude, status, verboseMassage, error) -> () in
//            self.displayLocation(location: CLLocation(latitude: latitude, longitude: longitude))
//        }
//    }
//
//    func displayLocation(location: CLLocation) {
//        let locationCordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
//        let locationSpan = MKCoordinateSpanMake(0.05, 0.05)
//        let regionCoordinats = MKCoordinateRegion(center: locationCordinate, span: locationSpan)
//        mapView.setRegion(regionCoordinats, animated: true)
//        let pinLocationCordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = pinLocationCordinate
//        mapView.addAnnotation(annotation)
//        mapView.showAnnotations([annotation], animated: true)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status != CLAuthorizationStatus.notDetermined || status != CLAuthorizationStatus.denied || status != CLAuthorizationStatus.restricted {
//            getLocation()
//        }
//    }
    
    
    
    
    


}
