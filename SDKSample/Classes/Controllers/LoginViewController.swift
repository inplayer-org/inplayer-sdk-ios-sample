//
//  LoginViewController.swift
//  SDKSample
//
//  Created by Oliver Dimitrov on 7/13/19.
//  Copyright © 2019 InPlayer. All rights reserved.
//

import UIKit
import InPlayerSDK

class LoginViewController: UIViewController {
    @IBOutlet var enviormentLabel: UILabel!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func loginPressed(_ sender: Any) {
        // initialize sdk
        let configuration = InPlayer.Configuration(clientId: "7ad8a510-b720-4a18-aa38-0260e5fd1cb2",
                                                   environment: .staging) // change to take real env.
        InPlayer.initialize(configuration: configuration)
        // log in
    }
}
