//
//  GasStation.swift
//  kitt
//
//  Created by Ondřej Mařík on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import Foundation

class GasStation {
    
    var name: String
    var lat: String
    var long: String
    var price: Float
    
    init(dict: [String: AnyObject]) {
        
        name = dict["name"] as? String ?? ""
        lat = dict["lat_n"] as? String ?? ""
        long = dict["lon_n"] as? String ?? ""
        price = Float(dict["prices"]?["0004"] as? String ?? "40") ?? 40
        
    }
    
}

