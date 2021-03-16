//
//  SharedKeyDto.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 23/01/19.
//  Copyright © 2019 Resource. All rights reserved.
//

import UIKit

class UserDto: NSObject {

    public func generateParameters(deviceId: String, tokenCode: String) -> NSDictionary {
        
        return [
            "DeviceId": deviceId,
            "CodigoToken": tokenCode
        ]
        
    }
    
    public func generateParametersFingerPrint(fingerPrint: String) -> NSDictionary {
        
        return [
            "fingerprint": fingerPrint
        ]
        
    }
    
}
