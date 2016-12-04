//
//  BaseVC.swift
//  kitt
//
//  Created by Ondřej Mařík on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    var isNotificationActive = false

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showNotification() {
        if isNotificationActive == false {
            if let notificationVC = storyboard?.instantiateViewController(withIdentifier: "notificationVC") as? NotificationVC {
                present(notificationVC, animated: true, completion: nil)
            }
        }
    }
}
