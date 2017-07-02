//
//  ProductListConfigurator.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

class ProductListConfigurator {
    func configure(viewController: ProductListViewController) {
        viewController.productListService = ProductListService()
    }
}
