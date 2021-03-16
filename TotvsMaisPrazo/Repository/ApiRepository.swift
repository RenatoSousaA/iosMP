//
//  ApiRepository.swift
//  SupplierAppMais
//
//  Created by Bruno Sena on 09/11/18.
//  Copyright © 2018 Resource. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

class ApiRepository: NSObject {

    static let sharedManager = ApiRepository()
    
    private func getDefaultHeaders() -> HTTPHeaders {
        
        return [ "Content-Type": "application/json",
                 "Accept": "application/json"
        ]
        
    }
    
    public func get(path: String, parameters: NSDictionary, completion: @escaping (JSON) -> (), failure: @escaping (String) -> ()) {

        let server: String = Bundle.main.object(forInfoDictionaryKey: "ConnectionString") as! String

        let fullPath: String = String.init(format: "%@%@", server, path)

        let url: URLConvertible = URL.init(string: fullPath)!

        let headers = self.getDefaultHeaders()

        let body = parameters as! Parameters
        
        Alamofire.request(url, method: .get, parameters: body, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in

                switch response.result {

                case .success(let value):
                    let json = JSON(value)
                    completion(json)

                case .failure(let error):
                    failure(error.localizedDescription)

                }

        }

    }
    
    public func getQueryString(path: String, parameters: NSDictionary, completion: @escaping (JSON) -> (), failure: @escaping (String) -> ()) {

        let server: String = Bundle.main.object(forInfoDictionaryKey: "ConnectionString") as! String

        let fullPath: String = String.init(format: "%@%@", server, path)

        let url: URLConvertible = URL.init(string: fullPath)!

        let headers = self.getDefaultHeaders()

        let body = parameters as! Parameters
        
        Alamofire.request(url, method: .get, parameters: body, encoding: URLEncoding(destination: .queryString), headers: headers)
            .validate()
            .responseJSON { (response) in

                switch response.result {

                case .success(let value):
                    let json = JSON(value)
                    completion(json)

                case .failure(let error):
                    failure(error.localizedDescription)

                }

        }

    }
    
    public func post(path: String, parameters: NSDictionary, completion: @escaping (JSON) -> (), failure: @escaping (String) -> ()) {
        
        let server: String = Bundle.main.object(forInfoDictionaryKey: "ConnectionString") as! String
        
        let fullPath: String = String.init(format: "%@%@", server, path)
        
        let url: URLConvertible = URL.init(string: fullPath)!
        
        let headers: HTTPHeaders = getDefaultHeaders()
        
        let body = parameters as! Parameters
        
        Alamofire.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                
                switch response.result {
                    
                case .success(let value):
                    let json = JSON(value)
                    completion(json)
                    
                case .failure(let error):
                    failure(error.localizedDescription)
                    
                }
                
        }
        
    }
    
}
