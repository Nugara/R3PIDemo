//
//  LiveQuote.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

struct LiveQuote {
    let source: String
    let quotes: [String: Double]
    
    init(map : [String : AnyObject]) {
        source = map["source"] as! String
        quotes = map["quotes"] as! [String : Double]
    }
}
