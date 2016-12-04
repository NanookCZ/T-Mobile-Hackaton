//
//  MenuVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var name: UILabel!
    
    var selectedCar: Vehicle?
    let menuItems = ["My garage", "Car state", "Ride", "Users"]
    let menuIcons = ["MyGarage", "CarState", "CarRide", "Users"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.backgroundColor = UIColor.clear
        navigationController?.navigationBar.shadowImage = UIImage()
        
        tableView.layer.cornerRadius = 5.0
        tableView.clipsToBounds = true
        
        if let selectedCar = Model.instance.selectedCar {
            self.selectedCar = selectedCar
            self.name.text = selectedCar.Name
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        cell.configureCell(label: menuItems[indexPath.row], imageName: menuIcons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "garageSegue", sender: self)
            
        case 1:
            performSegue(withIdentifier: "stateSegue", sender: self)
            
        case 2:
            performSegue(withIdentifier: "rideSegue", sender: self)
            
        case 3:
            performSegue(withIdentifier: "usersSegue", sender: self)
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
