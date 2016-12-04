//
//  StateVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

class StateVC: BaseVC {
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var carImage: UIImageView!
    
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var added: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var registration: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var owners: UILabel!
    
    @IBOutlet weak var notifications: UISwitch!
    @IBAction func notificationsAction(_ sender: UISwitch) {
        Model.instance.switchNotifications = sender.isOn
    }
    
    @IBOutlet weak var speachNotifications: UISwitch!
    @IBAction func speachNotificationsAction(_ sender: UISwitch) {
        Model.instance.switchSpeachNotifications = sender.isOn
    }
    
    @IBOutlet weak var nightMode: UISwitch!
    @IBAction func nightModeAction(_ sender: UISwitch) {
        Model.instance.switchNightMode = sender.isOn
    }

    @IBOutlet weak var notificationsRide: UISwitch!
    @IBAction func notificationsRideAction(_ sender: UISwitch) {
        Model.instance.switchNotificationDuringRide = sender.isOn
    }
    
    @IBOutlet weak var hotspots: UISwitch!
    @IBAction func hotspotsAction(_ sender: UISwitch) {
        Model.instance.switchShareHotspots = sender.isOn
    }

    @IBOutlet weak var gps: UISwitch!
    @IBAction func gpsAction(_ sender: UISwitch) {
        Model.instance.switchShareGps = sender.isOn
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let car = Model.instance.selectedCar else {
            return
        }
        
        if let url = URL(string: car.VehicleImage?.Normal ?? "") {
            carImage.af_setImage(withURL: url)
        }


        bgView.layer.cornerRadius = 5.0
        bgView.clipsToBounds = true
        
        if let car = Model.instance.selectedCar {
            vin.text = car.VIN
            added.text = car.CreatedOn
            name.text = car.Name
            registration.text = car.LicensePlate
        }
        
        Model.instance.getAllCarUsers(success: { (users) in
            self.owners.text = "\(users.count)"
        }, failure: {error in
        print(error)}
        )
        
        notifications.setOn(Model.instance.switchNotifications, animated: true)
        nightMode.setOn(Model.instance.switchNightMode, animated: true)
        notificationsRide.setOn(Model.instance.switchNotificationDuringRide, animated: true)
        hotspots.setOn(Model.instance.switchShareHotspots, animated: true)
        gps.setOn(Model.instance.switchShareGps, animated: true)
        speachNotifications.setOn(Model.instance.switchSpeachNotifications, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
