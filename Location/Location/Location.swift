//
//  Location.swift
//  Location
//
//  Created by Sai Voruganti on 5/8/25.
//

import Foundation
import CoreLocation



class LocationManager: NSObject, CLLocationManagerDelegate {
        let locationManager = CLLocationManager()
        var onLocationUpdate: ((Double, Double) -> Void)?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    func startUpdating() {
            locationManager.startUpdatingLocation()
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        onLocationUpdate?(loc.coordinate.latitude, loc.coordinate.longitude)
        locationManager.stopUpdatingLocation()
    }
    
}

