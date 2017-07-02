//
//  BasketConfigurator.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 02/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

class BasketConfigurator {
    
    var controller : BasketViewController?
    
    func configure(viewController: BasketViewController) {
        
        self.controller = viewController
        setupCurrencyList()
        setupLiveQuoteService()
    }
    
    func setupCurrencyList() {
        
        let networking = URLSessionNetworking()
        let currencyListParsing = CurrencyListJSONParser()
        
        let currencyListService = CurrencyListService(baseURL: Configuration.baseURL, accessKey: Configuration.accessKey, networking: networking, currencyListParsing: currencyListParsing)
        
        self.controller!.currencyListService = currencyListService
    }
    
    func setupLiveQuoteService() {
        
        let networking = URLSessionNetworking()
        let liveQuoteParsing = LiveQuoteJSONParser()
        
        let liveQuoteService = LiveQuoteService(baseURL: Configuration.baseURL, accessKey: Configuration.accessKey, networking: networking, liveQuoteParsing: liveQuoteParsing)
        
        self.controller!.liveQuoteService = liveQuoteService
    }
}
