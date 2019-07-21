//
//  AlertsManager.swift
//  SDKSample
//
//  Created by Oliver Dimitrov on 7/21/19.
//  Copyright © 2019 InPlayer. All rights reserved.
//

import UIKit

enum AlertReturnKey {
    case ok, cancel, yes, no
}

typealias AlertCallback = (_ returnKey: AlertReturnKey) -> ()


class AlertsManager {
    static func showAlert(title: String, message: String, controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    static func showAlert(message: String, controller: UIViewController) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
        
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
    
    static func showOkAlert(title: String? = nil, message: String, callback: AlertCallback? = nil) {
        showAlert(title: title, message: message, actions: [okAction(callback)])
    }
    
    static func showOkCancelAlert(title: String? = nil, message: String, callback: AlertCallback? = nil) {
        showAlert(title: title, message: message, actions: [cancelAction(callback), okAction(callback)])
    }
    
    static func showYesNoAlert(title: String? = nil, message: String, callback: AlertCallback? = nil) {
        showAlert(title: title, message: message, actions: [noAction(callback), yesAction(callback)])
    }
    
    //MARK: Private
    private static func showAlert(title: String?, message: String, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alertController.addAction(action)
        }
        
        DispatchQueue.main.async {
            UIApplication.topViewController()?.present(alertController, animated: true)
        }
    }
    
    private static func okAction(_ callback: AlertCallback?) -> UIAlertAction {
        let action = UIAlertAction(title: "Ok", style: .default) { action in
            callback?(.ok)
        }
        return action
    }
    
    private static func cancelAction(_ callback: AlertCallback?) -> UIAlertAction {
        let action = UIAlertAction(title: "Cancel", style: .cancel) { action in
            callback?(.cancel)
        }
        return action;
    }
    
    private static func yesAction(_ callback: AlertCallback?) -> UIAlertAction {
        let action = UIAlertAction(title: "Yes", style: .default) { action in
            callback?(.yes)
        }
        return action
    }
    
    private static func noAction(_ callback: AlertCallback?) -> UIAlertAction {
        let action = UIAlertAction(title: "No", style: .default) { action in
            callback?(.no)
        }
        return action
    }
}
