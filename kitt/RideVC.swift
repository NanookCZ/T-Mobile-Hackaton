//
//  RideVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK

class RideVC: UIViewController {

    @IBOutlet var containerView: UIView!
    @IBOutlet var imgCar: UIImageView!
    
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
    
    var car: Vehicle? {
        didSet {
            if let car = car {
                
                lblFirst.text = String(describing: car.VehicleSpeed?.Value)
                lblSecond.text = String(describing: car.VehicleFuelVolume?.Value)
                lblThird.text = String(describing: car.DiagnosticCodes.count)
                
                lblNearestMeters.text = "134 m"
                lblOilState.text = car.VehicleBattery?.RiskSeverity
                lblOilAmount.text = "\(car.VehicleBattery?.Value ?? 0.0 / 1000) V"
                
                lblCurrentConsumption.text = String(describing: car.VehicleFuelEfficiency?.Value)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        containerView.layer.cornerRadius = 5.0
        
        lblFirstSubtitle.text = "Avg speed"
        lblSecondSubtitle.text = "Fuel/l"
        lblThirdSubtitle.text = "Errors"
        
        lblNearestService.text = "Nearest service"
        lblNearestStation.text = "Nearest station"
    }

    
    
}
