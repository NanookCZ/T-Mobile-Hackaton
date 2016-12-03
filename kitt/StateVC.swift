//
//  StateVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

class StateVC: UIViewController {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var added: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var owners: UILabel!
    
    @IBOutlet weak var notifications: UISwitch!
    @IBAction func notificationsAction(_ sender: UISwitch) {
    }
    
    @IBOutlet weak var nightMode: UISwitch!
    @IBAction func nightModeAction(_ sender: UISwitch) {
    }

    @IBOutlet weak var notificationsRide: UISwitch!
    @IBAction func notificationsRideAction(_ sender: UISwitch) {
    }
    
    @IBOutlet weak var hotspots: UISwitch!
    @IBAction func hotspotsAction(_ sender: UISwitch) {
    }

    @IBOutlet weak var gps: UISwitch!
    @IBAction func gpsAction(_ sender: UISwitch) {
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bgView.layer.cornerRadius = 5.0
        bgView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
