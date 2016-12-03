//
//  GarageCollCell.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

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
    
    func configureCell(car: String, index: IndexPath) {
        self.index = index
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
