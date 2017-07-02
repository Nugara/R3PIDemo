//
//  LiveQuoteJSONParser.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

class LiveQuoteJSONParser: LiveQuoteParsing {
    
    func parse(data: Data?) -> LiveQuote? {
        
        guard let responseData = data else {
            return nil
        }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                print("error trying to convert data to JSON")
                
                return nil
            }
            
            let quoteModel = LiveQuote(map: json)
            return quoteModel
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
}
