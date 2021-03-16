//
//  SecurityRepository.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 07/01/19.
//  Copyright © 2019 Resource. All rights reserved.
//

import UIKit

import didm_auth_sdk_iOS

class SecurityRepository: NSObject {

    static let sharedManager = SecurityRepository()

    public func saveBarCode(barcode: String, token: String, qrCode: String, completion: @escaping (Bool) -> (), failure: @escaping (Bool, String) -> ()) {
        
        let path = "salvarCodBarras"
        
        let parameters = SaveBarCodeDto().generateParameters(barcode: barcode, token: token, qrCode: qrCode)
        
        ApiRepository.sharedManager.post(path: path, parameters: parameters, completion: { (response) in
            
            let status = response["status"].stringValue
            
            if status.lowercased().elementsEqual("ok") {
                completion(true)
                return
            }
            
            SecurityDomain.sharedManager.clearPaymentQRCode()
            
            let message = response["mensagem"].stringValue
            
            failure(true, message)
            
        }) { (error) in
            failure(false, error)
        }
        
    }
    
    public func getTokenValue() -> String? {
        
        let accounts: [Account] = AppDelegate.tokenInstance?.getAccounts()! as! [Account]
        
        if nil == accounts || accounts.count < 1 {
            NSLog("Token ERROR")
            return nil
        }
        
        return AppDelegate.tokenInstance?.otp_API.getTokenValue(accounts[0])
        
    }
    
    public func getDeviceId() -> String? {
        
        let accounts: [Account] = AppDelegate.tokenInstance?.getAccounts()! as! [Account]
        
        if nil == accounts || accounts.count < 1 {
            NSLog("Token ERROR")
            return nil
        }
        
        return AppDelegate.tokenInstance?.getDeviceID()

        
    }
    
    public func getUserInformation(deviceId: String, tokenCode: String, completion: @escaping (NSDictionary) -> (), failure: @escaping (String) -> ()) {
        
        let path = "consultarSharedKey"
        
        let parameters = UserDto().generateParameters(deviceId: deviceId, tokenCode: tokenCode)
        
        ApiRepository.sharedManager.post(path: path, parameters: parameters, completion: { (response) in
            
            let result = SharedKeyResultDto.toDomain(json: response)
            
            completion(result)
        }) { (error) in
            failure(error)
        }
        
    }
    
    public func getDeviceIdByFingerPrint(fingerPrint: String, completion: @escaping (NSDictionary) -> (), failure: @escaping (String) -> ()) {
        
        let path = "api/codRefToken/deviceID"
        
        let parameters = UserDto().generateParametersFingerPrint(fingerPrint: fingerPrint)
        
        ApiRepository.sharedManager.getQueryString(path: path, parameters: parameters, completion: { (response) in
            
            let result = SharedKeyResultDto.getDeviceIDAPI(json: response)
            
            completion(result)
        }) { (error) in
            failure(error)
        }
        
    }
    
}
