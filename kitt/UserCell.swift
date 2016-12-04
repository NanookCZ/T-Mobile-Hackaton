//
//  UserCell.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK
import AlamofireImage

class UserCell: UITableViewCell {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var ownership: UILabel!
    @IBOutlet weak var lastDrive: UILabel!
    @IBOutlet weak var separatorView: SeparatorView!

    func configureCell(user: User) {
        
        if let url = URL(string: user.Img?.Thumbnail ?? "") {
            userImage.af_setImage(withURL: url)
            
            self.userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
            self.userImage.clipsToBounds = true
        }
        
        if let first = user.FirstName, let last = user.LastName {
            userName.text = first + " " + last
        }
        
        ownership.text = user.LastName == "Margetova" ? "Prague Owner" : "Prague Co-owner"
        lastDrive.text = "Prague Co-owner"
    }
}
