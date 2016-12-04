//
//  Model.swift
//  kitt
//
//  Created by Ondřej Mařík on 29/11/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import Foundation
import MojioSDK
import Alamofire
import CoreLocation

class Model {
    
    // Singleton property
    static let instance = Model()
    
    private let authClient: AuthClient
    private var restClient: RestClient {
        return RestClient(clientEnvironment: ClientEnvironment.SharedInstance)
    }
    
    // MARK: Public properties
    var currentCars: [Vehicle]?
    var selectedCar: Vehicle?
    var carUsers = [User]()

    var gasStations: [GasStation] = []
    
    // MARK: Switches
    var switchNotifications = false
    var switchNightMode = false
    var switchNotificationDuringRide = false
    var switchShareHotspots = false
    var switchShareGps = false
    var switchTwistoPayments = false
    var switchSpotify = false
    var switchShareRide = false

    var selectedLocation: CLLocation?
    var dateFormatter: DateFormatter = DateFormatter()
    
    // MARK: Class private constructor
    private init() {
        
        authClient = AuthClient(clientId: "0b655654-4021-43d3-b556-5da5f8ec4d90", clientSecretKey: "fbb2113a-9260-4c4a-8be3-2e0e7573a6f9", clientRedirectURI: "app://asdf")
        
        DateFormatter.dateFormat(fromTemplate: "yyyy-MM-dd'T'HH:mm:ss.SSSZ", options: 0, locale: Locale.current)
        
    }
    
    // MARK: Public functions
    public func login(username: String?, password: String?, success: @escaping () -> Void, failure: @escaping (ModelError) -> Void ) {
    
        guard let username = username, let password = password else {
            failure(.MissingParams)
            return
        }
        
        authClient.login(username, password: password, completion: { token in
            self.authClient.saveAuthToken(token)
            success()
            self.initGasStations()
        }, failure: { error in
            failure(.WrongCredentials)
        })
        
    }
    
    public func getAllCarUsers(success: @escaping ([User]) -> Void, failure: @escaping (ModelError) -> Void) {
        createAnotherUser()
        self.userInfo(success: { (user) in
            self.carUsers.append(user)
            success(self.carUsers)
        }, failure: { (error) in
            print(error)
            failure(error)
        }
        )
        
    }
    
    func createAnotherUser() {
        let newUser = User()
        newUser.FirstName = "Dalibor"
        newUser.LastName = "Kozak"
        
        let image = Image()
        image.Src = "https://images.moj.io/v2/images/23d3637c-6d5a-4c7a-9840-2f492eddb0c9.jpeg"
        image.Normal = "https://images.moj.io/v2/images/23d3637c-6d5a-4c7a-9840-2f492eddb0c9.jpeg?w=1280&h=720"
        image.Thumbnail = "https://images.moj.io/v2/images/23d3637c-6d5a-4c7a-9840-2f492eddb0c9.jpeg?w=50&h=50&mode=crop"
        newUser.Img = image
        newUser.LastModified = "2016-12-03T16:43:12.237Z"
        newUser.Id = "ef3ab3c6-137b-48db-a126-4ddb849c7203"
        self.carUsers.append(newUser)
    }
    
    func getUserDetails(userId: String) {
        
    }

    
    public func logout() {
        
        authClient.logout()
        
    }
    
    public func userCars(success: @escaping ([Vehicle]) -> Void, failure: @escaping (ModelError) -> Void) {
        
        restClient.get().vehicles(nil).run({ (vehicles) in
            self.currentCars = vehicles as? [Vehicle]
            success(vehicles as? [Vehicle] ?? [])
        }, failure: { error in
            failure(self.parsedError(error: error))
        }
        )
        
    }
    
    public func userInfo(success: @escaping (User) -> Void, failure: @escaping (ModelError) -> Void) {
        
        restClient.get().me().run({ (user) in
            success(user as! User)
        }, failure: { error in
            failure(self.parsedError(error: error))
        })
        
    }
    
    // Gas stations
    public func travelPath(start: CLLocation, end: CLLocation, success: ([String : AnyObject]) -> Void, failure: (ModelError) -> Void) {
        
        let parameters = ["action" : "getDirectionsAndPumps",
                          "startPlace" : "\(start.coordinate.latitude),\(start.coordinate.longitude)",
                          "endPlace" : "\(end.coordinate.latitude),\(end.coordinate.longitude)"]
        
        Alamofire.request("https://fleetheroapi.ccs.cz/index.php", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                print(response)
        }
        
        
    }
    
    public func gasStations(success: @escaping ([String : AnyObject]) -> Void, failure: @escaping (ModelError) -> Void) {
        
        let parameters = ["action" : "getAllAggPumpsWithPositionNoLevels"]
        
        Alamofire.request("https://fleetheroapi.ccs.cz/index.php", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let dict):
                    success(dict as? [String : AnyObject] ?? [:])
                case .failure(let error):
                    failure(.APIError(error.localizedDescription))
                }
        }
        
    }
    
    // Weather
    public func currentWeather(location: CLLocation, success: ([String : AnyObject]) -> Void, failure: (ModelError) -> Void) {
        
        let parameters = ["key":"39e772ad39c34c81afa113737160212",
                          "q":"\(location.coordinate.latitude),\(location.coordinate.longitude)"]
        
        Alamofire.request("https://api.apixu.com/v1/current.json", method: .get, parameters: parameters)
        .validate()
        .responseJSON { (response) in
            print(response)
        }
        
    }
    
    public func incidentsInLocation(corner1: CLLocation, corner2: CLLocation, success: ([String : AnyObject]) -> Void, failure: (ModelError) -> Void) {
        
        let parameters = ["key":"AuwECp1VPpdEviDCTCDAbx1SzwA2qM_-YWpU5gbQXLJ9WL-zZjrUga2Q0BZ6k-Pu"]
        
        Alamofire.request("https://dev.virtualearth.net/REST/v1/Traffic/Incidents/\(corner1.coordinate.latitude),\(corner1.coordinate.longitude),\(corner2.coordinate.latitude),\(corner2.coordinate.longitude)", method: .get, parameters: parameters)
            .validate()
            .responseJSON { (response) in
                print(response)
        }
        
    }
    
    // MARK: Private stuff
    private func parsedError(error: Any?) -> ModelError {
        
        if let message = (error as? [String: Any])?["Message"] as? String {
            return .APIError(message)
        } else if let message = error as? String {
            return .APIError(message)
        } else {
            return .APIError(nil)
        }
    }
    
    private func initGasStations() {
        
        gasStations(success: { (dictionary) in
            self.gasStations = []
            let sites = dictionary["sites"] as? [[String: Any]] ?? []
            for site in sites {
                self.gasStations.append(GasStation(dict: site as [String : AnyObject]))
            }
        }, failure: { error in
            print(error)
        })
        
    }
    
}

enum ModelError: Error {
    case MissingParams
    case APIError(String?)
    case WrongCredentials
    
    func localizedDescription() -> String {
        switch self {
        case .MissingParams:
            return "Missing input values"
        case .APIError(let message):
            return message ?? "General API error"
        case .WrongCredentials:
            return "Incorrect login information"
        }
        
    }
    
}
