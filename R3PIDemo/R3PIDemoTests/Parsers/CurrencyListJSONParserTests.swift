//
//  CurrencyListJSONParserTests.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import XCTest
@testable import R3PIDemo

class CurrencyListJSONParserTests: XCTestCase {
    
    func test_GivenEmptyData_WhenParse_ThenCurrencyListNil() {
        
        let parser = CurrencyListJSONParser()
        let currencyList = parser.parse(data: nil)
        
        XCTAssertNil(currencyList)
    }
    
    func test_GivenCorrectData_WhenParse_ThenCurrencyList() {
        
        let parser = CurrencyListJSONParser()
        let base64 = givenCurrencyListBase64Response()
        let currencyList = parser.parse(data: Data(base64Encoded: base64))
        
        XCTAssertNotNil(currencyList)
    }
    
    func test_GivenMalformedJSONData_WhenParseCurrencyList_ThenCurrencyListNil() {
        
        //<http>generic html error</http>
        
        let parser = CurrencyListJSONParser()
        let currencyList = parser.parse(data: Data(base64Encoded: "PGh0dHA+Z2VuZXJpYyBodG1sIGVycm9yPC9odHRwPg=="))
        XCTAssertNil(currencyList)
    }
}

// MARK: - Utils
extension CurrencyListJSONParserTests {
    
    fileprivate func givenCurrencyListBase64Response() -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "currencyListBase64", ofType: "")!
        return try! String(contentsOfFile: path, encoding: .utf8)
    }
}
