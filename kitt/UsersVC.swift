//
//  UsersVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {

    @IBOutlet weak var bgView: UIView!

    @IBOutlet weak var integrations: UILabel!
    @IBOutlet weak var km: UILabel!
    @IBOutlet weak var rides: UILabel!
    
    @IBOutlet weak var twisto: UISwitch!
    @IBAction func twistoAction(_ sender: UISwitch) {
        Model.instance.switchTwistoPayments = sender.isOn
    }

    @IBOutlet weak var wifi: UISwitch!
    @IBAction func wifiAction(_ sender: UISwitch) {
        Model.instance.switchShareHotspots = sender.isOn
    }

    @IBOutlet weak var spotify: UISwitch!
    @IBAction func spotifyAction(_ sender: UISwitch) {
        Model.instance.switchSpotify = sender.isOn
    }

    @IBOutlet weak var shareRide: UISwitch!
    @IBAction func shareRideAction(_ sender: UISwitch) {
        Model.instance.switchSpotify = sender.isOn
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bgView.layer.cornerRadius = 5.0
        bgView.clipsToBounds = true
        
        twisto.setOn(Model.instance.switchTwistoPayments, animated: true)
        wifi.setOn(Model.instance.switchShareHotspots, animated: true)
        spotify.setOn(Model.instance.switchSpotify, animated: true)
        shareRide.setOn(Model.instance.switchSpotify, animated: true)

        integrations.text = ""
        km.text = ""
        rides.text = ""
        
    }
}
