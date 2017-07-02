//
//  CurrencyListJSONParser.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import Foundation

class CurrencyListJSONParser: CurrencyListParsing {
    func parse(data: Data?) -> [Currency]? {
        
        guard let responseData = data else {
            return nil
        }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                print("error trying to convert data to JSON")
                
                return nil
            }
            
            guard let currencies = json["currencies"] as? [String : String] else {
                
                return nil
            }
            
            var currenciesList : [Currency] = []
            
            for (key, value) in currencies {
                
                currenciesList.append(Currency(code: key, label: value))
            }
            
            return currenciesList
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
}
