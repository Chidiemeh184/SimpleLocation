//
//  RegionMonitoringViewController.swift
//  SimpleLocation
//
//  Created by Chidi Emeh on 3/14/18.
//  Copyright © 2018 Chidi Emeh. All rights reserved.
//

import UIKit
import CoreLocation

class RegionMonitoringViewController: UIViewController {

    var locationManager = CLLocationManager()
    var monitoringLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        monitoringLocation = CLLocation(latitude: 37.331600000000002, longitude: -122.0301)
        locationManager.requestAlwaysAuthorization()
        
    }

}


extension RegionMonitoringViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self){
               
                let region = CLCircularRegion(center: (monitoringLocation?.coordinate)!, radius: 300, identifier: "Apple HQ")
                region.notifyOnEntry = true
                region.notifyOnExit = true
                locationManager.startMonitoring(for: region)
            }
            
            for region in locationManager.monitoredRegions {
                print(region.identifier)
            }
            
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed with an error")
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Region Entered")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Region Exited")
    }
    
    
    
}
