//
//  ViewController.swift
//  SimpleLocation
//
//  Created by Chidi Emeh on 3/13/18.
//  Copyright © 2018 Chidi Emeh. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager : CLLocationManager?
    var startLocation : CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}


extension ViewController : CLLocationManagerDelegate {
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if startLocation == nil {
            startLocation = locations.first
            print("\(String(describing: startLocation))")
        }else {
            guard let latest = locations.first else { return }
            let distanceInMeters = startLocation?.distance(from: latest)
            print("distance in meters: \(String(describing: distanceInMeters))")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error : \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            //locationManager?.startUpdatingLocation()
            locationManager?.requestLocation()
            locationManager?.allowsBackgroundLocationUpdates = true
        }
    }
    

}
