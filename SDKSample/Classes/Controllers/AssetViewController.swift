//
//  AssetViewController.swift
//  SDKSample
//
//  Created by Oliver Dimitrov on 7/21/19.
//  Copyright © 2019 InPlayer. All rights reserved.
//

import UIKit
import InPlayerSDK
import StoreKit

class AssetViewController: UIViewController {

    @IBOutlet weak var assetIDField: UITextField!
    @IBOutlet weak var assetFeeIDField: UITextField!
    
    private var iapHelper: IAPHelper?
    private var product: SKProduct?
    
    private var assetID: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // register for purchase notification
        
    }
    
    @IBAction func onGetAssetPressed(_ sender: Any) {
        // check if asset is available
        if let assetIdString = assetIDField.text,
            let assetID = assetIdString.intValue,
            let feeIdString = assetFeeIDField.text {
            self.assetID = assetID
            InPlayer.Asset.checkAccessForAsset(id: assetID, success: { (itemAccess) in
                // show some info
            }) { (error) in
                // check if error code 402 which means it requires payment
                if error.code == 402 {
                    self.buyProduct(identifier: assetIdString + "_" + feeIdString)
                } else {
                    // show error
                    self.showError(message: error.message)
                }
            }
        } else {
            showError(message: "Please fill out the fields.")
        }
    }
    
    private func buyProduct(identifier: String) {
        
        func validatePurchase(identifier: String, receipt: String) {
            InPlayer.Payment.validate(receiptString: receipt,
                                      productIdentifier: identifier,
                                      success: {
                                        print("success")
                InPlayer.Asset.checkAccessForAsset(id: self.assetID!, success: { (itemAccess) in
                    print(itemAccess)
                }, failure: { (error) in
                    self.showError(message: error.message)
                })
            }) { (error) in
                self.showError(message: error.message)
            }
        }
        
        func buy(product: SKProduct) {
            self.iapHelper?.buyProduct(product, completionHandler: { (success, transaction) in
                if !success {
                    // show error
                    self.showError(message: transaction?.error?.localizedDescription)
                } else {
                    if let receipt = transaction?.transactionIdentifier {
                        validatePurchase(identifier: identifier, receipt: receipt)
                    } else {
                        // show custom error message
                        self.showError(message: "Transaction identifier not present.\nPayment failed.")
                    }
                }
            })
        }
        
        let productIdentifiers: Set<ProductIdentifier> = [identifier]
        self.iapHelper = IAPHelper(productIds: productIdentifiers)
        self.iapHelper?.requestProducts({ (success, products, error) in
            if success, let product = products?.first {
                self.product = product
                buy(product: product)
            } else {
                // show error
                self.showError(message: error?.localizedDescription)
            }
        })
    }
    
    private func showError(message: String?) {
        print(message)
    }
    
    private func showInfo() {
        
    }
}
