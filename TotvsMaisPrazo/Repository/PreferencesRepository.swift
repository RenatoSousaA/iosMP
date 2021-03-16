//
//  PreferencesRepository.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 22/11/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

class PreferencesRepository: NSObject {

    static let sharedManager = PreferencesRepository()
    
    public func save(key: String, item: Any) {
        UserDefaults.standard.set(item, forKey: key)
    }
    
    public func delete(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    public func get(key: String) -> Any? {
        
        if nil != UserDefaults.standard.object(forKey: key) {
            return UserDefaults.standard.value(forKey: key)
        }
        return nil
    }
    
}
