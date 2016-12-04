//
//  RideVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK
import AlamofireImage
import CoreLocation

class RideVC: UIViewController, UITextFieldDelegate {

    @IBOutlet var containerView: UIView!
    @IBOutlet var imgCar: UIImageView!
    @IBOutlet var searchContainerView: UIView!
    
    @IBOutlet var lblFirst: UILabel!
    @IBOutlet var lblSecond: UILabel!
    @IBOutlet var lblThird: UILabel!
    
    @IBOutlet var lblFirstSubtitle: UILabel!
    @IBOutlet var lblSecondSubtitle: UILabel!
    @IBOutlet var lblThirdSubtitle: UILabel!
    
    @IBOutlet var lblOilState: UILabel!
    @IBOutlet var lblOilAmount: UILabel!
    @IBOutlet var lblNearestService: UILabel!
    @IBOutlet var lblNearestMeters: UILabel!
    
    @IBOutlet var lblFuelLevel: UILabel!
    @IBOutlet var lblFuelType: UILabel!
    @IBOutlet var lblNearestStation: UILabel!
    @IBOutlet var lblStationPrice: UILabel!
    
    @IBOutlet var lblEstimate: UILabel!
    @IBOutlet var lblCurrentConsumption: UILabel!
    @IBOutlet var effectiveTanking: UILabel!
    @IBOutlet var totalPrice: UILabel!
    
    @IBOutlet var txtSearch: UITextField!
    
    var car: Vehicle? {
        didSet {
            if let car = car {
                
                if let url = URL(string: car.VehicleImage?.Normal ?? "") {
                    imgCar.af_setImage(withURL: url)
                }
                
                lblFirst.text = String(describing: car.VehicleSpeed?.Value ?? 0.0)
                lblSecond.text = String(describing: car.VehicleFuelEfficiency?.Value ?? 0.0)
                lblThird.text = String(describing: car.DiagnosticCodes.count)
                
                lblNearestMeters.text = "134 m"
                lblOilState.text = (car.VehicleBattery?.RiskSeverity ?? "") + " Risk"
                lblOilAmount.text = "\(car.VehicleBattery?.Value ?? 0.0 / 1000) V"
                
                lblFuelLevel.text = String(describing: car.VehicleFuelVolume?.Value ?? 0.0) + " l fuel level"
                lblFuelType.text = car.FuelType
                lblCurrentConsumption.text = String(describing: car.VehicleFuelEfficiency?.Value ?? 0.0) + " l/100km"
                
                lblStationPrice.text = nearestGasStation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        car = Model.instance.selectedCar
        
        // Do any additional setup after loading the view.
        containerView.layer.cornerRadius = 5.0
        
        lblFirstSubtitle.text = "Avg speed"
        lblSecondSubtitle.text = "Fuel/l"
        lblThirdSubtitle.text = "Errors"
        
        lblNearestService.text = "Nearest service"
        lblNearestStation.text = "Nearest station"
    }

    func nearestGasStation() -> String {
        
        let stations = Model.instance.gasStations
        
        guard stations.count > 0 && car?.VehicleLocation != nil else { return "" }
        
        let carLocation = CLLocation(latitude: CLLocationDegrees(car!.VehicleLocation!.Lat), longitude: CLLocationDegrees(car!.VehicleLocation!.Lng))
        
        let cheapestStation = stations.reduce((stations.first!.location.distance(from: carLocation), stations.first!.price), { ( result, station) in
            
            let newDistance = station.location.distance(from: carLocation)
            if newDistance < result.0 {
                return (newDistance, station.price)
            }
            return result
        })
        
        
        return String(Int(cheapestStation.0)) + " m, " + String(cheapestStation.1) + " Kč"
        
    }
    
    @IBAction func searchTouchUpInside(_ sender: UITextField) {
        
        let geocoder = CLGeocoder()
        
        if sender.text != nil && sender.text!.characters.count > 0 {
            geocoder.geocodeAddressString(sender.text!, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.showAlert(title: nil, message: "The was an error processing your destination.")
                } else if placemarks?.count == 0 {
                    self.showAlert(title: nil, message: "No destinations found for your query")
                } else {
                    print(placemarks)
                }
            })
        } else {
            showAlert(title: nil, message: "You need to fill in destination")
        }
        
    }
}
