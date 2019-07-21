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
    
    private var environments: [InPlayerEnvironmentType] = [.staging, .production]
    private var selectedEnvironment: InPlayerEnvironmentType = .staging {
        didSet {
            enviormentLabel.text = "Environment: " + selectedEnvironment.rawValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedEnvironment = .staging
    }


    @IBAction func loginPressed(_ sender: Any) {
        // initialize sdk
        initializeSDK()
        loginUser()
    }
    
    @IBAction func environmentPressed(_ sender: Any) {
        // show picker
        let pickerView = PickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.alpha = 0
        view.addSubview(pickerView)
        UIView.animate(withDuration: 0.25) {
            pickerView.alpha = 1
        }
    }
    
    private func initializeSDK() {
        let configuration = InPlayer.Configuration(clientId: "7ad8a510-b720-4a18-aa38-0260e5fd1cb2",
                                                   environment: selectedEnvironment) // change to take real env.
        InPlayer.initialize(configuration: configuration)
        
    }
    
    private func loginUser() {
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            return
        }
        InPlayer.Account.authenticate(username: email, password: password, success: { (authorization) in
            // show payment screen
            UIApplication.mainWindow?.rootViewController = MainAssembly.assetViewController()
            UIApplication.mainWindow?.makeKeyAndVisible()
        }) { (error) in
            var message: String = ""
            if let errorList = error.errorList {
                message = errorList.reduce(message) { $0 + "\n" + $1 }
            } else {
                message = error.localizedDescription
            }
            AlertsManager.showOkAlert(message: message)
        }
    }
}

extension LoginViewController: PickerViewDelegate {
    func onCancelPressed(_ pickerView: PickerView) {
        UIView.animate(withDuration: 0.25, animations: {
            pickerView.alpha = 0
        }) { (done) in
            if done {
                pickerView.removeFromSuperview()
            }
        }
    }
    
    func onDonePressed(_ pickerView: PickerView, selectedRow row: Int) {
        selectedEnvironment = environments[row]
        UIView.animate(withDuration: 0.25, animations: {
            pickerView.alpha = 0
        }) { (done) in
            if done {
                pickerView.removeFromSuperview()
            }
        }
    }
    
    func pickerView(_ pickerView: PickerView, didSelectRow row: Int) {
        selectedEnvironment = environments[row]
    }
    
}

extension LoginViewController: PickerViewDataSource {
    func numberOfItems(inView: PickerView) -> Int {
        return environments.count
    }
    func pickerView(_ pickerView: PickerView, titleForRow row: Int) -> String {
        return environments[row].rawValue
    }
}
