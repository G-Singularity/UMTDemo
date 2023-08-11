//
//  HUD.swift
//  BeersListDemo
//
//  Created by dqh on 10/8/23.
//

import MBProgressHUD
import Foundation

class Alert: NSObject {
    enum AlertType {
        case success
        case info
        case error
        case warning
    }
    
    class func show(type: AlertType, text: String) {
        if let window = kGetWindow() {
            var image: UIImage
            switch type {
            case .success:
                image = #imageLiteral(resourceName: "success")
            case .info:
                image = #imageLiteral(resourceName: "info")
            case .error:
                image = #imageLiteral(resourceName: "error")
            case .warning:
                image = #imageLiteral(resourceName: "warning")
            }
            let hud = MBProgressHUD.showAdded(to: window, animated: true)
            hud.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            hud.mode = .customView
            hud.customView = UIImageView(image:image)
            hud.label.text = text
            hud.hide(animated: true, afterDelay: 1.2)
        }
    }
}

class ProgressHUD {
    class func show() {
        if let window = UIApplication.shared.delegate?.window {
            MBProgressHUD.showAdded(to: window!, animated: true)
        }
    }
    
    class func hide() {
        if let window = UIApplication.shared.delegate?.window {
            MBProgressHUD.hide(for: window!, animated: true)
//            MBProgressHUD.hideAllHUDs(for: window!, animated: true)
        }
    }
}
