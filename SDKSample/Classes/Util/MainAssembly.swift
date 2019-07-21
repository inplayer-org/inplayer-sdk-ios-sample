//
//  MainAssembly.swift
//  SDKSample
//
//  Created by Oliver Dimitrov on 7/13/19.
//  Copyright © 2019 InPlayer. All rights reserved.
//

import UIKit

class MainAssembly {
    static func loginViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: LoginViewController.className)
    }
    
    static func assetViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Asset", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: AssetViewController.className)
    }
}
