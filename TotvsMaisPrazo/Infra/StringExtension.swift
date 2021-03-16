//
//  StringExtension.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 23/01/19.
//  Copyright © 2019 Resource. All rights reserved.
//

import UIKit

extension String {

    public func customSubstring(from position: Int, count: Int) -> String {
        
        var result = ""
        
        var index = 0
        var internalCounter = count
        
        for char in self {
            if index >= position && internalCounter > 0 {
                result += String(char)
                internalCounter = internalCounter - 1
                if internalCounter <= 0 {
                    break
                }
            }
            index = index + 1
        }
        
        return result
    }
    
}
