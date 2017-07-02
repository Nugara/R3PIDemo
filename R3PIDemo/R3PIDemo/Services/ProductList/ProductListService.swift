//
//  ProductListService.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

class ProductListService: ProductListServicing {

    func fetch(success: @escaping ([Product]) -> (), failure: @escaping (ProductListServicingError) -> ()) {
        
        let json : [[String : Any]] = [
            ["id" : "1", "name" : "Peas", "price" : 0.95, "unit" : "per bag", "image" : "icPeas"],
            ["id" : "2", "name" : "Eggs", "price" : 2.10, "unit" : "per dozen", "image" : "icEggs"],
            ["id" : "3", "name" : "Milk", "price" : 1.30, "unit" : "per bottle", "image" : "icMilk"],
            ["id" : "4", "name" : "Beans", "price" : 0.73, "unit" : "per can", "image" : "icBeans"]
        ]
        
        var productList : [Product] = []
        
        for item in json {
            let product = Product(map: item)
            productList.append(product)
        }
        success(productList)
    }
}
