//
//  CurrencyListServiceStub.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 02/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation
@testable import R3PIDemo

class CurrencyListServiceStub: CurrencyListServicing {
    var responseSuccess = false
    var fetchCalled = false
    var liveQuoteStub: LiveQuote?
    var currencies: [Currency]?
    var errorStub: CurrencyListServicingError?
    
    func fetch(success: @escaping ([Currency]) -> (), failure: @escaping (CurrencyListServicingError) -> ()) {
        
        fetchCalled = true
        
        if responseSuccess {
            success(currencies!)
        } else {
            failure(errorStub!)
        }
    }
}
