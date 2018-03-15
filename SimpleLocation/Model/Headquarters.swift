//
//  Headquarters.swift
//  SimpleLocation
//
//  Created by Chidi Emeh on 3/15/18.
//  Copyright © 2018 Chidi Emeh. All rights reserved.
//

import UIKit
import MapKit


class Headquarters : NSObject {
    
    let name : String
    let type : String
    let location : CLLocation
    let image : UIImage?
    
    
    init(name : String, type : String, imageName : String, latitude : Double, longitude : Double) {
        self.name = name
        self.type = type
        self.location = CLLocation(latitude: latitude, longitude: longitude)
        self.image = UIImage(named: imageName)
    }

}


extension Headquarters : MKAnnotation {
    var coordinate : CLLocationCoordinate2D {
        get{ return location.coordinate }
    }
    
    var title : String? {
        get { return name }
    }
    
    var subtitle : String? {
        get { return type}
    }
    
}
