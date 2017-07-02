//
//  ProductListServiceStub.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation
@testable import R3PIDemo

class ProductListServiceStub: ProductListService {
    var responseSuccess = false
    var fetchCalled = false
    var productListStub: [Product]?
    var errorStub: ProductListServicingError?
    
    override func fetch(success: @escaping ([Product]) -> (), failure: @escaping (ProductListServicingError) -> ()) {
        
        fetchCalled = true
        if responseSuccess {
            success(productListStub!)
        } else {
            failure(errorStub!)
        }
    }
}
