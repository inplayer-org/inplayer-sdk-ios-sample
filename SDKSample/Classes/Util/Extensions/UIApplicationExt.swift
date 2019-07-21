//
//  UIApplicationExt.swift
//  SDKSample
//
//  Created by Oliver Dimitrov on 7/21/19.
//  Copyright © 2019 InPlayer. All rights reserved.
//

import UIKit

extension UIApplication {
    
    class var mainWindow: UIWindow? {
        let appDelegate = shared.delegate as? AppDelegate
        return appDelegate?.window
    }
    
    class func topViewController(_ viewController: UIViewController? = mainWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }
}
