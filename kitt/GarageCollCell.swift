//
//  GarageCollCell.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK

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

    @IBOutlet weak var bgView: UIView!
    
    var index: IndexPath?
    var carUsers = [User]()
    
    
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
        self.index = index
        createAnotherUser()
        
        if let url = URL(string: car.VehicleImage?.Normal ?? "") {
            carImage.af_setImage(withURL: url)
        }
        year.text = car.CreatedOn
        distance.text = (String(describing: car.VehicleOdometer?.Value ?? 0.0)) + (car.VehicleOdometer?.Unit ?? "")
        
        if let userId = car.Id {
            getUserDetails(userId: userId)
        }
    }
    
    func createAnotherUser() {
        let newUser = User()
        newUser.FirstName = "Dalibor"
        newUser.LastName = "Kozak"
        
        let image = Image()
        image.Src = "https://images.moj.io/v2/images/23d3637c-6d5a-4c7a-9840-2f492eddb0c9.jpeg"
        image.Normal = "https://images.moj.io/v2/images/23d3637c-6d5a-4c7a-9840-2f492eddb0c9.jpeg?w=1280&h=720"
        image.Thumbnail = "https://images.moj.io/v2/images/23d3637c-6d5a-4c7a-9840-2f492eddb0c9.jpeg?w=50&h=50&mode=crop"
        newUser.Img = image
        newUser.LastModified = "2016-12-03T16:43:12.237Z"
        newUser.Id = "ef3ab3c6-137b-48db-a126-4ddb849c7203"
        self.carUsers.append(newUser)
    }
    
    func getUserDetails(userId: String) {
        Model.instance.userInfo(success: { (user) in
            self.carUsers.append(user)
            self.tableView.reloadData()
        }, failure: { (error) in
            print(error)
        })
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
