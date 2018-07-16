//
//  LocationManager.swift
//  ByteMark
//
//  Created by Amardeep on 15/07/18.
//  Copyright © 2018 Amardeep. All rights reserved.
//

import UIKit
import MapKit

protocol LocationManagerDelegate {
    func didUpdateLocation(iCurrentCity: String)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    var locationManager:CLLocationManager?
    var delegate:LocationManagerDelegate?
    var isDelegateCalled = false
    
    static let sharedManager = LocationManager()
    private override init() {
        super.init()
        
        self.locationManager = CLLocationManager()
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.locationManager?.distanceFilter = 10.0
        self.locationManager?.delegate = self
        self.locationManager?.requestWhenInUseAuthorization()
    }
    
    func fetchCurrentCity() {
        self.isDelegateCalled = false
        if CLLocationManager.locationServicesEnabled() == true {
            self.locationManager?.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let theLocation: CLLocation = manager.location else {
            return
        }
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(theLocation) { (iPlaceMarks, iError) in
            if iError == nil {
                let firstLocation = iPlaceMarks?[0]
                if self.isDelegateCalled == false {
                    self.isDelegateCalled = true
                    self.delegate?.didUpdateLocation(iCurrentCity: firstLocation?.locality ?? "")
                    self.locationManager?.stopUpdatingLocation()
                    print("Location updated")
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
}
