//
//  SaveBarCodeDto.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 07/01/19.
//  Copyright © 2019 Resource. All rights reserved.
//

import UIKit

class SaveBarCodeDto: NSObject {

    public func generateParameters(barcode: String, token: String, qrCode: String) -> NSDictionary {
        
        return [
            "codigoBarras": barcode,
            "codigoToken": token,
            "qrCode": qrCode
        ]
        
    }
    
}
