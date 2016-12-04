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

class RideVC: BaseVC, UITextFieldDelegate {

    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var imgCar: UIImageView!
    @IBOutlet var searchContainerView: UIView!
    @IBOutlet var infoContainerView: UIView!
    
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
    @IBOutlet var butSet: AnimatedButton!
    
    var car: Vehicle? {
        didSet {
            if let car = car {
                
                lblFirst.text = String(describing: car.VehicleSpeed?.Value ?? 0.0)
                lblSecond.text = String(describing: car.VehicleFuelEfficiency?.Value ?? 0.0)
                lblThird.text = String(describing: car.DiagnosticCodes.count)
                
                lblNearestMeters.text = "134 m"
                lblOilState.text = (car.VehicleBattery?.RiskSeverity ?? "") + " Risk"
                lblOilAmount.text = "\(car.VehicleBattery?.Value ?? 0.0 / 1000) V"
                
                lblFuelLevel.text = String(describing: car.VehicleFuelVolume?.Value ?? 0.0) + " l fuel level"
                lblFuelType.text = car.FuelType ?? "Diesel"
                lblCurrentConsumption.text = String(describing: car.VehicleFuelEfficiency?.Value ?? 0.0) + " l/100km"
                
                lblStationPrice.text = nearestGasStation()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        car = Model.instance.selectedCar
        imgCar.image = Model.instance.selectedCarImage
        
        butSet.layer.cornerRadius = 5.0
        butSet.layer.borderColor = UIColor.white.cgColor
        butSet.layer.borderWidth = 1.0
        butSet.clipsToBounds = true
        
        // Do any additional setup after loading the view.
        containerView.layer.cornerRadius = 5.0
        
        lblFirstSubtitle.text = "Avg speed"
        lblSecondSubtitle.text = "Fuel/l"
        lblThirdSubtitle.text = "Errors"
        
        lblNearestService.text = "Nearest service"
        lblNearestStation.text = "Nearest station"
        
        if Model.instance.selectedLocation == nil {
            searchContainerView.isHidden = false
            infoContainerView.isHidden = true
        } else {
            searchContainerView.isHidden = true
            infoContainerView.isHidden = false
        }
        
        // Tap to dismiss keyboard
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleViewTap(_:))))
        
        // Keyboard avoidance notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    // Keyboard
    func keyboardWillShow(_ notification: NSNotification) {
        
        // Animate the current view out of the way
        if let userInfo = notification.userInfo {
            let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
            
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            
            UIView.animate(withDuration: duration, delay: 0.0, options: animationCurve(fromInfo: userInfo), animations: {
                self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 8.0, 0.0)
                self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 8.0, 0.0)
            }, completion: nil)
            
        }
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        
        // And animate it back
        if let userInfo = notification.userInfo {
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            
            UIView.animate(withDuration: duration, delay: 0.0, options: animationCurve(fromInfo: userInfo), animations: {
                self.scrollView.contentInset = .zero
                self.scrollView.scrollIndicatorInsets = .zero
            }, completion: nil)
        }
        
    }
    
    func handleViewTap(_ sender: UIGestureRecognizer) {
        view.endEditing(true)
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        searchTouchUpInside(butSet)
        
        return true
    }
    
    @IBAction func searchTouchUpInside(_ sender: AnimatedButton) {
        
        let geocoder = CLGeocoder()
        
        if txtSearch.text != nil && txtSearch.text!.characters.count > 0 {
            geocoder.geocodeAddressString(txtSearch.text!, completionHandler: { (placemarks, error) in
                if error != nil {
                    self.showAlert(title: nil, message: "The was an error processing your destination.")
                } else if placemarks?.count == 0 {
                    self.showAlert(title: nil, message: "No destinations found for your query")
                } else {
                    let tripInfo = Model.instance.getTripInfo(location: placemarks!.first!.location!)
                    self.lblEstimate.text = String(Int(tripInfo.distance / 1000)) + " km"
                    
                    if let consumption = self.car?.VehicleFuelEfficiency?.Value {
                        self.lblCurrentConsumption.text = String(consumption) + " l/100km"
                    }
                    
                    let carLocation = CLLocation(latitude: Double(self.car?.VehicleLocation?.Lat ?? 0.0), longitude: Double(self.car?.VehicleLocation?.Lng ?? 0.0))
                    
                    self.effectiveTanking.text = tripInfo.bestStation.name + ", " + String(Int(tripInfo.bestStation.location.distance(from: carLocation))) + "m, " + String(tripInfo.bestStation.price) + " Kč"
                    
                    let consumption: Double = Double(self.car?.VehicleFuelEfficiency?.Value ?? 10.0) / 100.0
                    self.totalPrice.text = String(Double(tripInfo.bestStation.price) * (tripInfo.distance / 1000) * consumption)
                    
                    self.searchContainerView.isHidden = true
                    self.infoContainerView.isHidden = false
                }
            })
        } else {
            showAlert(title: nil, message: "You need to fill in destination")
        }
        
    }
    
    // MARK: - Utility
    
    /**
     Obtains animation type from notification dictionary
     
     - Parameters:
     - fromInfo: userInfo dictionary from notification
     
     - Returns: Animation options containing animation used for keyboard
     */
    func animationCurve(fromInfo userInfo: [AnyHashable: Any]) -> UIViewAnimationOptions {
        let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
        let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
        return UIViewAnimationOptions(rawValue: animationCurveRaw)
    }
}
