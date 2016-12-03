//
//  MenuVC.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedCar: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    let menuItems = ["My garage", "Car configuration", "Car state", "Ride", "Users"]
    let menuIcons = ["MyGarage", "CarConfig", "CarState", "CarRide", "Users"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        print(selectedCar ?? "nic")
        
        tableView.layer.cornerRadius = 5.0
        tableView.clipsToBounds = true
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
    
}
