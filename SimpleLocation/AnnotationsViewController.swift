//
//  AnnotationsViewController.swift
//  SimpleLocation
//
//  Created by Chidi Emeh on 3/15/18.
//  Copyright © 2018 Chidi Emeh. All rights reserved.
//

import UIKit
import MapKit

class AnnotationsViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    var headquaters = [Headquarters]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeadquarters()
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isRotateEnabled = false
        mapView.addAnnotations(headquaters)
        
        let regionRadius : CLLocationDistance = 20000
        let hq = headquaters.first
        let coordinateRegion = MKCoordinateRegionMakeWithDistance((hq?.location.coordinate)!, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadHeadquarters() {
        guard let plistUrl = Bundle.main.url(forResource: "headquarters", withExtension: "plist") else { return }
        var placedEntries = NSArray()
        
        do {
            
            let plistData = try Data.init(contentsOf: plistUrl)
            var format = PropertyListSerialization.PropertyListFormat.xml

            placedEntries = (try PropertyListSerialization.propertyList(from: plistData, options: .mutableContainersAndLeaves, format: &format) as? NSArray)!
            
        
            for property in placedEntries {
               
                if let propertyDict = property as? Dictionary<String, AnyObject> {
                        let name = propertyDict["Name"] as? String
                        let latitude = propertyDict["Latitude"] as? NSNumber
                        let longitude = propertyDict["Longitude"] as? NSNumber
                        let image = propertyDict["Image"] as? String
                        let type = propertyDict["Type"] as? String

                    
                    let companyHeadquaters = Headquarters(name: name!, type: type!, imageName: image!, latitude: latitude as! Double, longitude: longitude as! Double)
                    headquaters.append(companyHeadquaters)
                }
            }
            
        } catch {
            print("error reading plist")
        }
    }
    
    
}

extension AnnotationsViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "TechHQ") as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "TechHQ") as? MKPinAnnotationView
        }else {
            annotationView?.annotation = annotation
        }
        annotationView?.pinTintColor = UIColor.orange
        annotationView?.canShowCallout = true
        
        if let place = annotation as? Headquarters, let image = place.image {
            annotationView?.detailCalloutAccessoryView = UIImageView(image: image)
        }
        
        return annotationView
    }
    

}
