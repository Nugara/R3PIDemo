//
//  CurrencyLayerService.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

class LiveQuoteService: LiveQuoteServicing {
    
    private enum Constants {
        static let serviceName = "live"
    }
    
    private let baseURL: String
    private let accessKey: String
    private let networking: Networking
    private let liveQuoteParsing: LiveQuoteParsing
    
    init(baseURL: String, accessKey: String, networking: Networking, liveQuoteParsing: LiveQuoteParsing) {
        self.baseURL = baseURL
        self.accessKey = accessKey
        self.networking = networking
        self.liveQuoteParsing = liveQuoteParsing
    }
    
    func fetch(from sourceCurrency: String, to destinationCurrency: String, success: @escaping (LiveQuote) -> (), failure: @escaping (LiveQuoteServiceError) -> ()) {
        
        let endPoint = "\(baseURL)/\(Constants.serviceName)?access_key=\(accessKey)&currencies=\(sourceCurrency),\(destinationCurrency)&format=1"
        
        networking.httpGet(endpoint: endPoint, success: { data in
            guard data != nil else {
                failure(.generic)
                return
            }
            let liveQuote = LiveQuoteJSONParser().parse(data: data)
            
            if liveQuote != nil {
                success(liveQuote!)
            } else{
                failure(.generic)
            }
        }) { error in
            failure(.generic)
        }
    }
}
