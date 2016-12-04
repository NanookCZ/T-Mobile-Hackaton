//
//  GasStation.swift
//  kitt
//
//  Created by Ondřej Mařík on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import Foundation
import CoreLocation

class GasStation {
    
    var name: String
    var city: String
    var location: CLLocation
    var price: Float
    
    init?(dict: [String: AnyObject]) {
        
        if let gName = dict["name"] as? String,
            let gLat = dict["lat_n"] as? String,
            let gLon = dict["lon_n"] as? String {
            
            name = gName
            let lat = Double(gLat) ?? 0.0
            let long = Double(gLon) ?? 0.0
            location = CLLocation(latitude: lat, longitude: long)
            
        } else {
            return nil
        }

        city = dict["address_city"] as? String ?? ""
        price = (Float(dict["prices"]?["0004"] as? String ?? "40") ?? 40) * 27.0
        
    }
    
}

