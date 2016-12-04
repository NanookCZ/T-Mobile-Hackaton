//
//  Extensions.swift
//  kitt
//
//  Created by Dalibor Kozak on 03/12/2016.
//  Copyright © 2016 Ondřej Mařík. All rights reserved.
//

import UIKit
import pop

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

struct Colors {
    static let lightWhite = UIColor(netHex: 0xA3B3C7)

}

class AnimatedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
        
        self.addTarget(self, action: #selector(self.scaleToSmall), for: .touchDown)
        self.addTarget(self, action: #selector(self.scaleToSmall), for: .touchDragEnter)
        self.addTarget(self, action: #selector(self.scaleAnimation), for: .touchUpInside)
        self.addTarget(self, action: #selector(self.scaleToDefault), for: .touchDragExit)
    }
    
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 0.95, height: 0.95))
        self.layer.pop_add(scaleAnim, forKey: "scaleSmall")
    }
    
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0))
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 18
        self.layer.pop_add(scaleAnim, forKey: "scaleSmall")
    }
    
    func scaleToDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        self.layer.pop_add(scaleAnim, forKey: "scaleSmall")
    }
}

class AnimatedTableCell: UITableViewCell {
    @IBInspectable var cornerRadius: CGFloat = 10
    
    override func awakeFromNib() {
        setupView()
    }
    
    public func animate(sender: UITapGestureRecognizer) {
        self.scaleToSmall()
//        self.scaleAnimation()
//        self.scaleToDefault()
    }
    
    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }
    
    func scaleToSmall() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 0.95, height: 0.95))
        self.layer.pop_add(scaleAnim, forKey: "scaleSmall")
    }
    
    func scaleAnimation() {
        let scaleAnim = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.velocity = NSValue(cgSize: CGSize(width: 3.0, height: 3.0))
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        scaleAnim?.springBounciness = 18
        self.layer.pop_add(scaleAnim, forKey: "scaleSmall")
    }
    
    func scaleToDefault() {
        let scaleAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnim?.toValue = NSValue(cgSize: CGSize(width: 1.0, height: 1.0))
        self.layer.pop_add(scaleAnim, forKey: "scaleSmall")
    }

}

extension UIViewController {
    
    /**
     Show alertView with specified properties
     
     - Parameters:
     - title: Text in title
     - message: Message shown in alert view
     - actions: Array of alert view actions
     
     */
    func showAlert(title: String?, message: String?, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for action in actions {
            alertController.addAction(action)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    /**
     Show alert view with default single action (OK) - for errors
     
     - Parameters:
     - title: Text in title
     - message: Message shown in alert view
     
     */
    func showAlert(title: String?, message: String?) {
        showAlert(title: title, message: message, actions: [UIAlertAction(title: "OK", style: .cancel, handler: nil)])
    }
    
}
