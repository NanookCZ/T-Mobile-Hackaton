//
//  GarageCell.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

class GarageCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var vin: UILabel!
    @IBOutlet weak var lastUsed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        carImage.layer.cornerRadius = 5.0
        carImage.clipsToBounds = true
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
