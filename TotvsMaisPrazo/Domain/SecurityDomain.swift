//
//  SecurityDomain.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 09/11/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

class SecurityDomain: NSObject {

    static let sharedManager = SecurityDomain()
    
    var activationKey = "activationKey"
    
    var paymentQRCodeKey = "paymentQRCodeKey"
    var qrCodeDateKey = "qrCodeDateKey"
    
    public func activate(barcode: String, qrCode: String, tokenCode: String, completion: @escaping (Bool) -> (), failure: @escaping (String) -> ()) {
        
        let parameters = [
            "codigoBarras" : barcode,
            "codigoToken" : tokenCode,
            "qrCode" : qrCode
        ]
        
        ApiRepository.sharedManager.post(path: "salvarCodBarras", parameters: parameters as NSDictionary, completion: { (response) in
            completion(true)
        }) { (error) in
            failure(error)
        }
        
    }
    
    public func retrievePaymentQRCode() -> String? {
        
        let result = PreferencesRepository.sharedManager.get(key: paymentQRCodeKey) as? String
        
        if nil == result {
            return nil
        }
        
        let date = PreferencesRepository.sharedManager.get(key: qrCodeDateKey) as? Date
        
        let halfHour = 60 * 30
        
        let limitDate = date!.addingTimeInterval(TimeInterval(halfHour))
        
        let currentDate = Date()
        
        if currentDate > limitDate {
            self.clearPaymentQRCode()
            return nil
        }
        
        return result
    }
    
    public func savePaymentQRCode(code: String) {
        PreferencesRepository.sharedManager.save(key: paymentQRCodeKey, item: code)
        PreferencesRepository.sharedManager.save(key: qrCodeDateKey, item: Date())
    }
    
    public func clearPaymentQRCode() {
            PreferencesRepository.sharedManager.delete(key: paymentQRCodeKey)
            PreferencesRepository.sharedManager.delete(key: qrCodeDateKey)
    }
    
    public func notifyActivation() {
        PreferencesRepository.sharedManager.save(key: activationKey, item: true)
    }
    
    public func isActivated() -> Bool {
        if let isActivated = PreferencesRepository.sharedManager.get(key: activationKey) as? Bool {
            return isActivated
        }

        return false
    }
    
}
