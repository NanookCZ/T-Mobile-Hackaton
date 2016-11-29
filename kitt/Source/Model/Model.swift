//
//  Model.swift
//  kitt
//
//  Created by Ondřej Mařík on 29/11/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import Foundation
import MojioSDK

class Model {
    
    // Singleton property
    static let instance = Model()
    
    var authClient: AuthClient
    var restClient: RestClient
    
    // Class private constructor
    private init() {
        
        authClient = AuthClient(clientId: "9dfe8d0a-6ac3-49a8-9c85-6156145e2ed5", clientSecretKey: "916e92e9-96bc-449f-aca6-173f3d46332e", clientRedirectURI: "http://margetova.eu")
        restClient = RestClient(clientEnvironment: ClientEnvironment.SharedInstance)
        
    }
    
    
    
}
