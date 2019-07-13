//
//  AppDelegate.swift
//  SDKSample
//
//  Created by Oliver Dimitrov on 7/13/19.
//  Copyright © 2019 InPlayer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if window == nil { window  = UIWindow(frame: UIScreen.main.bounds) }
        window?.rootViewController = MainAssembly.loginViewController()
        window?.makeKeyAndVisible()

        return true
    }
}

