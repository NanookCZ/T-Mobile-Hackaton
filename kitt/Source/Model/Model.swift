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
    
    private let authClient: AuthClient
    private let restClient: RestClient
    
    private var authToken: AuthToken?
    
    // Class private constructor
    private init() {
        
        authClient = AuthClient(clientId: "0b655654-4021-43d3-b556-5da5f8ec4d90", clientSecretKey: "fbb2113a-9260-4c4a-8be3-2e0e7573a6f9", clientRedirectURI: "http://margetova.eu")
        restClient = RestClient(clientEnvironment: ClientEnvironment.SharedInstance)
        
    }
    
    // Public functions
    public func login(username: String?, password: String?, success: @escaping () -> Void, failure: @escaping (ModelError) -> Void ) {
    
        guard let username = username, let password = password else {
            failure(.MissingParams)
            return
        }
        
        authClient.login(username, password: password, completion: { token in
            success()
        }, failure: { error in
            failure(.WrongCredentials)
        })
        
    }
    
    
    
    
    
}

enum ModelError: Error {
    case MissingParams
    case WrongCredentials
    
    func localizedDescription() -> String {
        switch self {
        case .MissingParams:
            return "Missing input values"
        case .WrongCredentials:
            return "Incorrect login information"
        }
        
    }
    
}
