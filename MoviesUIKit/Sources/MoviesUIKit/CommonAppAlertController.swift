//
//  CommonAppAlertController.swift
//  
//
//  Created by Dinesh Kumar on 12/01/24.
//

import UIKit

extension UIViewController {
    /// Top most ViewController
    func topMostViewController() -> UIViewController {
        
        if self.presentedViewController == nil {
            return self
        }
        
        if let navigation = self.presentedViewController as? UINavigationController {
            return (navigation.visibleViewController?.topMostViewController())!
        }
        /*
         if let tab = self.presentedViewController as? UITabBarController {
         if let selectedTab = tab.selectedViewController {
         return selectedTab.topMostViewController()
         }
         return tab.topMostViewController()
         }
         */
        return (self.presentedViewController?.topMostViewController())!
    }
}

extension UIApplication {
    
/// Top most ViewController
    public func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}

public class CommonAppAlertController {
    public static func showAlert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = "MyAlert"
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        UIApplication.shared.topMostViewController()?.present(alert, animated: true, completion: nil)
    }
}

