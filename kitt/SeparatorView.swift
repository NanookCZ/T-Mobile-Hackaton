//
//  SeparatorView.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

class SeparatorView: UIView {
    
    override func awakeFromNib() {
        self.layer.borderColor = self.backgroundColor?.cgColor
        self.layer.borderWidth = (1.0 / UIScreen.main.scale) / 2
        self.backgroundColor = UIColor.clear
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
