//
//  Product.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

struct Product {
    let name: String
    let price: Double
    let unit: String
    let image : String
    
    init(map : [String : Any]) {
        name = map["name"] as! String
        price = map["price"] as! Double
        unit = map["unit"] as! String
        image = map["image"] as! String
    }
}
