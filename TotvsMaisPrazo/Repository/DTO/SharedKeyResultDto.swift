//
//  UserDto.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 23/01/19.
//  Copyright © 2019 Resource. All rights reserved.
//

import UIKit

import SwiftyJSON

class SharedKeyResultDto: NSObject {

    public static func toDomain(json: JSON) -> NSDictionary {
    
        let result = NSMutableDictionary()
        
        let user = User()
        
        if let itens = json["itens"].array {
            let item = itens[0]
            
            if let status = item["status"].string {
                result["status"] = status
                if !status.elementsEqual("001") {
                    return result
                }
            }
            
            if let cpfUsuario = item["cpfUsuario"].string {
                user.cpf = cpfUsuario
            }
            
            if let nomeUsuario = item["nomeUsuario"].string {
                user.name = nomeUsuario
            }
            
            if let descricaoTipoCliente = item["descricaoTipoCliente"].string {
                user.tipoCliente = descricaoTipoCliente
            }
            
            result["user"] = user
            
            if let mensagemAjuda = item["mensagemAjuda"].string {
                result["help"] = mensagemAjuda
            }
        }
        
        return result
    }
    
    public static func getDeviceIDAPI(json: JSON) -> NSDictionary {
        let result = NSMutableDictionary()
        
        guard let dados = json["dados"] as? JSON else {
            return result
        }
        
        guard let deviceIdAPI = dados["deviceId"] as? JSON else {
            return result
        }
        
        if let status = dados["deviceId"].string {
            result["deviceIdAPI"] = status
        }
        
        return result
    }
}
