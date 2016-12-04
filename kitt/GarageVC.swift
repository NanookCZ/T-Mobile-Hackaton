//
//  GarageVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK

class GarageVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var cars = [Vehicle]()
    var selectedVehicle: Vehicle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Model.instance.userCars(success: { (vehicles) in
            self.cars = vehicles
            self.tableView.reloadData()
        }, failure: { error in
            self.showAlert(title: "Error", message: error.localizedDescription())
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "garageCell", for: indexPath) as! GarageCell
        cell.configureCell(car: cars[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Model.instance.selectedCar = cars[indexPath.row]
        performSegue(withIdentifier: "menuSegue", sender: self)
    }
}
