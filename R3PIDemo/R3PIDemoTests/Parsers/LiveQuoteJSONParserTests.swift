//
//  LiveQuoteJSONParserTests.swift
//  R3PIDemo
//
//  Created by Giuseppe Nugara on 01/07/2017.
//  Copyright © 2017 Nugara. All rights reserved.
//

import XCTest
@testable import R3PIDemo

class LiveQuoteJSONParserTests: XCTestCase {
    
    func test_GivenEmptyData_WhenParse_ThenLiveQuoteNil() {
        
        let parser = LiveQuoteJSONParser()
        let liveQuote = parser.parse(data: nil)
        
        XCTAssertNil(liveQuote)
        
    }
    
    func test_GivenCorrectData_WhenParse_ThenCorrectLiveQuote() {
       
        //        {
        //            "success":true,
        //            "terms":"https:\/\/currencylayer.com\/terms",
        //            "privacy":"https:\/\/currencylayer.com\/privacy",
        //            "timestamp":1498909926,
        //            "source":"USD",
        //            "quotes":{
        //                "USDUSD":1,
        //                "USDEUR":0.874604
        //            }
        //
        let base64Encoded = "eyJzdWNjZXNzIjp0cnVlLCJ0ZXJtcyI6Imh0dHBzOi8vY3VycmVuY3lsYXllci5jb20vdGVybXMiLCJwcml2YWN5IjoiaHR0cHM6Ly9jdXJyZW5jeWxheWVyLmNvbS9wcml2YWN5IiwidGltZXN0YW1wIjoxNDk4OTAzMzMyLCJzb3VyY2UiOiJVU0QiLCJxdW90ZXMiOnsiVVNEVVNEIjoxLCJVU0RFVVIiOjAuODc0NjA0fX0="
        
        let parser = LiveQuoteJSONParser()
        let liveQuote = parser.parse(data: Data(base64Encoded: base64Encoded))
        
        XCTAssertNotNil(liveQuote)
        XCTAssertEqual(liveQuote?.source, "USD")
        XCTAssertEqual((liveQuote?.quotes)!, ["USDUSD": 1, "USDEUR": 0.874604])
    }
    
    func test_GivenMalformedJSONData_WhenParseQuote_ThenQuoteNil() {
        
        //<http>generic html error</http>
        let base64Encoded = "PGh0dHA+Z2VuZXJpYyBodG1sIGVycm9yPC9odHRwPg=="
        let parser = LiveQuoteJSONParser()
        let parsedQuote = parser.parse(data: Data(base64Encoded: base64Encoded))
        XCTAssertNil(parsedQuote)
    }
}
