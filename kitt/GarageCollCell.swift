//
//  GarageCollCell.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK
import AlamofireImage

class GarageCollCell: UICollectionViewCell, UITableViewDataSource {
       
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var owners: UILabel!
    @IBOutlet weak var selectButton: AnimatedButton!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var bgView: UIView!

    var carUsers = [User]()
    var thisCar: Vehicle?

    
    override func awakeFromNib() {
        tableView.dataSource = self
        selectButton.layer.cornerRadius = 5.0
        selectButton.layer.borderColor = Colors.lightWhite.cgColor
        selectButton.layer.borderWidth = 1.0
        selectButton.clipsToBounds = true
        bgView.layer.cornerRadius = 5.0
        bgView.clipsToBounds = true
    }
    
    func configureCell(car: Vehicle, index: IndexPath) {
        self.thisCar = car

        if let url = URL(string: car.VehicleImage?.Normal ?? "") {
            carImage.af_setImage(withURL: url)
        }
        year.text = car.CreatedOn
        distance.text = (String(describing: car.VehicleOdometer?.Value ?? 0.0)) + (car.VehicleOdometer?.Unit ?? "")

        if let userId = car.Id {
            getUserDetails(userId: userId)
        }
        
        if let dateStr = car.CreatedOn {
            guard let date = Model.instance.strintToDate(dateString: dateStr) else {
                year.text = "-"
                return
            }
            let yearComponent = Calendar.current.component(.year, from: date)
            year.text = String(yearComponent)
        }

        distance.text = String((describing: car.VehicleOdometer?.Value ?? 0.0) / 1000.0)
    }

    func getUserDetails(userId: String) {
        Model.instance.getAllCarUsers(success: { (users) in
            self.carUsers = users
            self.tableView.reloadData()
        }, failure: { failure in
            print(failure)
        })
    }

    @IBAction func selectButtonAction(_ sender: UIButton) {
        if let car = thisCar {
            Model.instance.selectedCar = car
        }
    }
    
    //MARK: TableView Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell"
            , for: indexPath) as! UserCell
        cell.configureCell(user: carUsers[indexPath.row])
        cell.separatorView.isHidden = indexPath.row == 0 ? true : false
        return cell
    }
    
}
