//
//  NotificationVC.swift
//  kitt
//
//  Created by Ondřej Mařík on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import MojioSDK
import AVFoundation

class NotificationVC: BaseVC {

    @IBOutlet var imgNotification: UIImageView!
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSpeed: UILabel!
    @IBOutlet var lblAverage: UILabel!
    @IBOutlet var lblMessage: UILabel!
    
    var car: Vehicle? {
        didSet {
            lblTitle.text = car?.Name
            
            if let car = car {
                let type = MessageType(car: car)
                    
                lblMessage.text = type.texts.0
                lblSpeed.text = type.texts.1
                lblAverage.text = type.texts.2
                
                lblMessage.font = UIFont(name: lblMessage.font.fontName, size: type.messageSize)
            }
            
        }
    }
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayNotification()
        NotificationCenter.default.addObserver(self, selector: #selector(displayNotification), name: NSNotification.Name(rawValue: "CarNotification"), object: nil)
    }
    
    func displayNotification() {
        
        if let notification = Model.instance.currentNotification {            
            lblSpeed.text = notification.texts.0
            lblTitle.text = "Speed warning"
            lblAverage.text =  notification.texts.1
            lblMessage.text =  notification.texts.2
            
            if Model.instance.switchSpeachNotifications {
                    let utterance = AVSpeechUtterance(string: "Please slow down")
                    utterance.voice = AVSpeechSynthesisVoice(identifier: "com.apple.ttsbundle.siri_female_en-GB_premium")
                    let synthesizer = AVSpeechSynthesizer()
                    synthesizer.speak(utterance)
            }
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
          isNotificationActive = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
          isNotificationActive = false
    }

}

enum MessageType {
    case Stop(String?, String?, String?)
    case Power
    case Lock
    case Spotify
    
    init(car: Vehicle) {
        
        
        
        self = .Spotify
    }
    
    var image: UIImage? {
        switch self {
        case .Stop(_, _, _):
            return UIImage(named: "stop")
        case .Power:
            return UIImage(named: "stop")
        case .Lock:
            return UIImage(named: "lock")
        case .Spotify:
            return UIImage(named: "spotify")
        }
    }
    
    var texts: (String?, String?, String?) {
        switch self {
        case .Stop(let main, let sub1, let sub2):
            return (main, sub1, sub2)
        case .Power:
            return (nil, nil, nil)
        case .Lock:
            return (nil, nil, nil)
        case .Spotify:
            return (nil, nil, nil)
        }
    }
    
    var messageSize: CGFloat {
        switch self {
        case .Stop(_, _, _), .Power, .Lock:
            return 32.0
        case .Spotify:
            return 20.0
        }
    }
    
}
