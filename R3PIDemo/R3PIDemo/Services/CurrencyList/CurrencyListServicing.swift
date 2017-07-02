//
//  CurrencyListService.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

enum CurrencyListServicingError: Error {
    case generic
}

protocol CurrencyListServicing {
    func fetch(success: @escaping ([Currency]) -> (), failure: @escaping (CurrencyListServicingError) -> ())
}
