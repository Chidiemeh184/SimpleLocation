//
//  GeocodingViewController.swift
//  SimpleLocation
//
//  Created by Chidi Emeh on 3/14/18.
//  Copyright © 2018 Chidi Emeh. All rights reserved.
//

import UIKit
import CoreLocation

class GeocodingViewController: UIViewController {

    
    @IBOutlet weak var lookupType: UISegmentedControl!
    @IBOutlet weak var results: UILabel!
    @IBOutlet weak var entry: UITextField!
    var geocoder: CLGeocoder? = nil
    
    @IBAction func lookupGeocoding(sender: UIButton) {
        
        if geocoder == nil {
            geocoder = CLGeocoder();
        }
        
        if lookupType.selectedSegmentIndex == 0 {
            
            geocoder?.geocodeAddressString(entry.text!) {
                [weak self] placemarks, error in
                let placemark = placemarks?.first
                let latitude = placemark?.location?.coordinate.latitude
                let longitude = placemark?.location?.coordinate.longitude
                let locationString = "\(latitude!) \(longitude!)"
                self?.results.text = locationString
            }
            
        } else {
            
            let coords = entry.text?.split(separator: " ")
            let latitude = Double(coords![0])!
            let longitude = Double(coords![1])!
            let location = CLLocation(latitude: latitude, longitude: longitude)
            geocoder?.reverseGeocodeLocation(location) {
                [weak self] placemarks, error in
                if placemarks!.count > 0 {
                    let placemark = placemarks?.first!
                    let streetNumber = placemark?.subThoroughfare
                    let street = placemark?.thoroughfare
                    let city = placemark?.locality
                    let state = placemark?.administrativeArea
                    let locationString = "\(streetNumber!) \(street!)\n\(city!), \(state!)"
                    self?.results.text = locationString
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    

}
