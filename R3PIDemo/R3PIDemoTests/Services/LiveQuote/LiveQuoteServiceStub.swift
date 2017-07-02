//
//  LiveQuoteServiceStub.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation
@testable import R3PIDemo

class LiveQuoteServiceStub: LiveQuoteServicing {
    var responseSuccess = false
    var fetchCalled = false
    var liveQuoteStub: LiveQuote?
    var errorStub: LiveQuoteServiceError?
    
    func fetch(from sourceCurrency: String, to destinationCurrency: String, success: @escaping (LiveQuote) -> (), failure: @escaping (LiveQuoteServiceError) -> ()) {
        
        fetchCalled = true
        
        if responseSuccess {
            success(liveQuoteStub!)
        } else {
            failure(errorStub!)
        }
    }
}
