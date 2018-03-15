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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeadquarters()
        // Do any additional setup after loading the view.
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
                    
                       print(propertyDict)
                }
             
            }
            
        } catch {
            print("error reading plist")
        }

        
    }
    
    
}
