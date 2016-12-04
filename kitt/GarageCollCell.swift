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

protocol GarageCollCellDelegate {
    func didSelectCar(index: IndexPath)
}

class GarageCollCell: UICollectionViewCell, UITableViewDataSource {
    
    var delegate: GarageCollCellDelegate?
   
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var owners: UILabel!
    @IBOutlet weak var selectButton: AnimatedButton!
    @IBOutlet weak var tableView: UITableView!

    var index: IndexPath?
    
    
    override func awakeFromNib() {
        tableView.dataSource = self
        selectButton.layer.cornerRadius = 5.0
        selectButton.layer.borderColor = Colors.lightWhite.cgColor
        selectButton.layer.borderWidth = 1.0
        selectButton.clipsToBounds = true
    }
    
    func configureCell(car: Vehicle, index: IndexPath) {
        self.index = index
        
        if let url = URL(string: car.VehicleImage?.Normal ?? "") {
            carImage.af_setImage(withURL: url)
        }
        if let date = Model.instance.dateFormatter.date(from: car.CreatedOn ?? "") {
            let yearComponent = Calendar.current.component(.year, from: date)
            year.text = String(yearComponent)
        }
        distance.text = String((describing: car.VehicleOdometer?.Value ?? 0.0) / 1000.0)
    }

    @IBAction func selectButtonAction(_ sender: UIButton) {
        if let index = index {
            delegate?.didSelectCar(index: index)
        }
    }
    
    //MARK: TableView Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell"
            , for: indexPath) as! UserCell
        cell.configureCell(car: "hello")
        return cell
    }
    
}
