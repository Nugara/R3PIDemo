//
//  CurrentListService.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

class CurrencyListService: CurrencyListServicing {
    
    private enum Constants {
        static let serviceName = "list"
    }

    private let baseURL: String
    private let accessKey: String
    private let networking: Networking
    private let currencyListParsing: CurrencyListParsing
    
    init(baseURL: String, accessKey: String, networking: Networking, currencyListParsing: CurrencyListParsing) {
        self.baseURL = baseURL
        self.accessKey = accessKey
        self.networking = networking
        self.currencyListParsing = currencyListParsing
    }
    
    func fetch(success: @escaping ([Currency]) -> (), failure: @escaping (CurrencyListServicingError) -> ()) {
        
        let endPoint = "\(baseURL)/\(Constants.serviceName)?access_key=\(accessKey)"
        
        networking.httpGet(endpoint: endPoint, success: { data in
            guard data != nil else {
                failure(.generic)
                return
            }
            
            let currencies = CurrencyListJSONParser().parse(data: data)
            
            if currencies != nil {
                success(currencies!)
            } else {
                failure(.generic)
            }
        
        }) { error in
            failure(.generic)
        }
    }
}
