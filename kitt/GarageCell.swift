//
//  GarageCell.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK
import AlamofireImage

class GarageCell: AnimatedTableCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var lastUsed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        background.layer.cornerRadius = 5.0
        background.clipsToBounds = true
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
    
    func configureCell(car: Vehicle) {
        if let url = URL(string: car.VehicleImage?.Normal ?? "") {
            carImage.af_setImage(withURL: url)
        }
        name.text = car.Name
        vin.text = car.VIN
        lastUsed.text = car.LastModified
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
