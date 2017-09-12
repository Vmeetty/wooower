//
//  Map.swift
//  Wooower
//
//  Created by vlad on 27.07.17.
//  Copyright © 2017 vladCh. All rights reserved.
//

import MapKit
import UIKit

class Map: NSObject, CLLocationManagerDelegate {
    
    var coreLocationManager = CLLocationManager()
    var location: CLLocation?
    
    func configLocation () {
        coreLocationManager.delegate = self
        coreLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        coreLocationManager.requestWhenInUseAuthorization()
        coreLocationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
    }
    
    

    
}
