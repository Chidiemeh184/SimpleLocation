//
//  MapKitViewController.swift
//  SimpleLocation
//
//  Created by Chidi Emeh on 3/15/18.
//  Copyright © 2018 Chidi Emeh. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController {

    @IBOutlet weak var mapkitView: MKMapView!
    
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appleHQ = CLLocation(latitude: 37.331177, longitude: -122.031641)
        let regionRadius  : CLLocationDistance = 1000.0
        let region = MKCoordinateRegionMakeWithDistance(appleHQ.coordinate, regionRadius, regionRadius)
        mapkitView.setRegion(region, animated: true)
        mapkitView.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
}

extension MapKitViewController : CLLocationManagerDelegate {
    
}

extension MapKitViewController : MKMapViewDelegate {
    
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("Rendering")
    }
}
