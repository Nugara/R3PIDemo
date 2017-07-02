//
//  ProductListServising.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

enum ProductListServicingError: Error {
    case generic
}

protocol ProductListServicing {

    func fetch(success: @escaping ([Product]) -> (), failure: @escaping (ProductListServicingError) -> ())
}
