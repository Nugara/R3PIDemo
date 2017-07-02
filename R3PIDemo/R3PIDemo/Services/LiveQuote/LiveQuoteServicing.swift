//
//  CurrencyService.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

enum LiveQuoteServiceError: Error {
    case generic
}

protocol LiveQuoteServicing {
    func fetch(from sourceCurrency: String, to destinationCurrency: String, success: @escaping (LiveQuote) -> (), failure: @escaping (LiveQuoteServiceError) -> ())
}
